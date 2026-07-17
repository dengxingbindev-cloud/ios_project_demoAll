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

        collectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
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
        
        cell.configure(
            with: item[indexPath.item],
            isSelected: indexPath.item == selectedIndex
        )
        
        return cell
        
    }
}

extension CameraWheelViewController1:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("haha")
    }

}

extension CameraWheelViewController1 {

    func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView
    ) {

        print("停止滚动")
        
        let center = CGPoint(
            x: collectionView.bounds.midX + collectionView.contentOffset.x,
            y: collectionView.bounds.midY
        )

        guard
            let layout = collectionView.collectionViewLayout
                as? CameraWheelLayout1,
            let indexPath = layout.centeredIndexPath
        else {
            return
        }

        print("中心Cell:", indexPath.item)

        let oldIndex = selectedIndex

        selectedIndex = indexPath.item
        
        collectionView.reloadItems(at: [
            IndexPath(item: oldIndex, section: 0),
            IndexPath(item: selectedIndex, section: 0)
        ])
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
