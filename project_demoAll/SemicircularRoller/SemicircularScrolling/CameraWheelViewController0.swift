import UIKit
import SnapKit

class CameraWheelViewController0: UIViewController {
    
    let items = [
        ZoomItem(value: "0.5x"),
        ZoomItem(value: "1x"),
        ZoomItem(value: "2x"),
        ZoomItem(value: "3x"),
        ZoomItem(value: "5x"),
        ZoomItem(value: "10x")
    ]
    
    let collectionView: UICollectionView = {

        let layout = CameraWheelLayout()
        
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

extension CameraWheelViewController0{
    private func setupUI() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}

extension CameraWheelViewController0:UICollectionViewDataSource{
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
            
            withReuseIdentifier: CameraWheelCell0.identifier,
            
            for: indexPath
            
        ) as! CameraWheelCell0
        
        cell.configure(with: item[indexPath.item])
        
        return cell
        
    }
}

extension CameraWheelViewController0:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("haha")
    }

}


private extension CameraWheelViewController0{
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CameraWheelCell0.self,
                                            forCellWithReuseIdentifier: CameraWheelCell0.identifier)
    }
}

private extension CameraWheelViewController0{
    func bindEvents(){
        
    }
}


@available(iOS 17,*)
#Preview {
    CameraWheelViewController0()
}
