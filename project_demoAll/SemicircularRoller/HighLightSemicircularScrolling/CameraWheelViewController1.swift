import UIKit
import SnapKit

class CameraWheelViewController1: UIViewController {
    
    let items = [
        ZoomItem(value: "0.5x"),
        ZoomItem(value: "1x"),
        ZoomItem(value: "2x"),
        ZoomItem(value: "3x"),
        ZoomItem(value: "5x"),
        ZoomItem(value: "10x")
    ]
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 1
        return view
    }()
    
    let collectionView: UICollectionView = {

        let layout = CameraWheelLayout1()
        
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false

        return cv

    }()
    
    private let item:[ZoomItem]
    
    private var selectedIndex = 0
    
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

extension CameraWheelViewController1{
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(indicatorView)

        indicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top).offset(-8)
            make.width.equalTo(2)
            make.height.equalTo(24)
        }

        collectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}

extension CameraWheelViewController1:UICollectionViewDataSource{
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
            
            withReuseIdentifier: CameraWheelCell1.identifier,
            
            for: indexPath
            
        ) as! CameraWheelCell1
        
        cell.configure(with: item[indexPath.item])
        
        return cell
        
    }
}

extension CameraWheelViewController1:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("haha")
    }

}

private extension CameraWheelViewController1{
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CameraWheelCell1.self,
                                            forCellWithReuseIdentifier: CameraWheelCell1.identifier)
    }
}

private extension CameraWheelViewController1{
    func bindEvents(){
        
    }
}


@available(iOS 17,*)
#Preview {
    CameraWheelViewController1()
}
