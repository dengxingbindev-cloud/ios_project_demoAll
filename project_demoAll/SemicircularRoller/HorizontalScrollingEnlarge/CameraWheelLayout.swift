import UIKit
import SnapKit
//布局相关
class CameraWheelLayout: UICollectionViewFlowLayout {
    
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

        print("prepare")
    }
    
    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {

        // 先拿到系统计算好的 Attributes
        guard let attributes = super.layoutAttributesForElements(in: rect)?
            .compactMap({ $0.copy() as? UICollectionViewLayoutAttributes }) else {
            return nil
        }

        // 拿到 CollectionView
        guard let collectionView = collectionView else {
            return attributes
        }

        // 计算当前屏幕中心 X
        let centerX = collectionView.contentOffset.x
                    + collectionView.bounds.width / 2

        print("-----------")
        
        // 遍历每一个 Cell
        for attribute in attributes {

            let distance = abs(attribute.center.x - centerX)
            
            let maxDistance: CGFloat = 200
            
            let limitedDistance = min(distance, maxDistance)
            
            let scale = 1 - (limitedDistance / maxDistance) * 0.4
            
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)

            print(distance)
        }

        print("-----------")
        
        // 返回修改后的 Attributes
        return attributes
    }
    
    override func shouldInvalidateLayout(
        forBoundsChange newBounds: CGRect
    ) -> Bool {

        return true
    }
    
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
            layoutAttributesForElements(in: targetRect)
        else {
            return proposedContentOffset
        }

        var minOffset = CGFloat.greatestFiniteMagnitude

        for attribute in attributes {

            let offset = attribute.center.x - proposedCenterX

            if abs(offset) < abs(minOffset) {
                minOffset = offset
            }
        }

        return CGPoint(
            x: proposedContentOffset.x + minOffset,
            y: proposedContentOffset.y
        )
    }
}
