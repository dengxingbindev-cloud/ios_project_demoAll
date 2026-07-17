import UIKit
import SnapKit
//布局相关
class CameraWheelLayout1: UICollectionViewFlowLayout {
    
    var centeredIndexPath: IndexPath?
    
    override class var layoutAttributesClass: AnyClass {

        return CameraWheelLayoutAttributes.self

    }
    
    //呃 初始化布局
    override func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 20
        minimumInteritemSpacing = 10
        
        itemSize = CGSize(width: 70, height: 70)
        
        guard let collectionView = collectionView else {
            return
        }

        let inset =
        (collectionView.bounds.width - itemSize.width) / 2

        sectionInset = UIEdgeInsets(
            top: 0,
            left: inset,
            bottom: 0,
            right: inset
        )

    }
    
    //在这里修改Cell布局
    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {

        // 先拿到系统计算好的 Attributes
        guard let attributes =
            super.layoutAttributesForElements(in: rect)?
                .map({ $0.copy() as! CameraWheelLayoutAttributes })
        else {
            return nil
        }

        // 拿到 CollectionView
        guard let collectionView = collectionView else {
            return attributes
        }

        // 计算当前屏幕中心 X
        let centerX = collectionView.contentOffset.x
                    + collectionView.bounds.width / 2
        
        // 遍历每一个 Cell
        for attribute in attributes {

            let distance = abs(attribute.center.x - centerX)
            
            attribute.distance = distance
            
            let maxDistance: CGFloat = 200

            let linear = 1 - min(distance / maxDistance, 1)

            let progress = sin(linear * .pi / 2)
            
            attribute.progress = progress
            
            attribute.zIndex = Int(progress * 1000)
        }
        
        // 返回修改后的 Attributes
        return attributes
    }
    
    //滚动实时刷新
    override func shouldInvalidateLayout(
        forBoundsChange newBounds: CGRect
    ) -> Bool {

        return true
    }
    
    
    //自动吸附
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {

        guard let collectionView = collectionView else {
            return proposedContentOffset
        }

        let proposedCenterX =
            proposedContentOffset.x + collectionView.bounds.width / 2

        let targetRect = CGRect(
            origin: CGPoint(
                x: proposedContentOffset.x,
                y: 0
            ),
            size: collectionView.bounds.size
        )

        guard let attributes =
            super.layoutAttributesForElements(in: targetRect)
        else {
            return proposedContentOffset
        }

        var minOffset = CGFloat.greatestFiniteMagnitude
        
        var nearestAttribute: UICollectionViewLayoutAttributes?

        for attribute in attributes {

            let offset = attribute.center.x - proposedCenterX

            if abs(offset) < abs(minOffset) {
                minOffset = offset
                nearestAttribute = attribute
            }
        }
        
        centeredIndexPath = nearestAttribute?.indexPath

        return CGPoint(
            x: proposedContentOffset.x + minOffset,
            y: proposedContentOffset.y
        )
    }
}
