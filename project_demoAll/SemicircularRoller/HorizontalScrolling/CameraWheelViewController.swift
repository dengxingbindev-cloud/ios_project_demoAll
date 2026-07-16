import UIKit
import SnapKit

class CameraWheelViewController: UIViewController {
    
    let items = [
        ZoomItem(value: "0.5x"),
        ZoomItem(value: "1x"),
        ZoomItem(value: "2x"),
        ZoomItem(value: "3x"),
        ZoomItem(value: "5x"),
        ZoomItem(value: "10x")
    ]
    
    let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10

        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false

        return cv

    }()
    
    private let item:[ZoomItem]
    
    init() {
        
        self.item = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        bindEvents()
    }
}

extension CameraWheelViewController{
    private func setupUI() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}

extension CameraWheelViewController:UICollectionViewDataSource{
    func collectionView(
        
        _ collectionView: UICollectionView,
        
        numberOfItemsInSection section: Int
        
    ) -> Int {
        
        return item.count
        
    }
    
    func collectionView(
        
        _ collectionView: UICollectionView,
        
        cellForItemAt indexPath: IndexPath
        
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            
            withReuseIdentifier: CameraWheelCell.identifier,
            
            for: indexPath
            
        ) as! CameraWheelCell
        
        cell.configure(with: item[indexPath.item])
        
        return cell
        
    }
}

extension CameraWheelViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("haha")
    }

}

extension CameraWheelViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {

        return UIEdgeInsets(
            top: 5,
            left: 5,
            bottom: 5,
            right: 5
        )
    }
}

private extension CameraWheelViewController{
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CameraWheelCell.self,
                                            forCellWithReuseIdentifier: CameraWheelCell.identifier)
    }
}

private extension CameraWheelViewController{
    func bindEvents(){
        
    }
}


@available(iOS 17,*)
#Preview {
    CameraWheelViewController()
}
