import UIKit

class CameraWheelLayoutAttributes: UICollectionViewLayoutAttributes {

    var progress: CGFloat = 0
    
    var distance: CGFloat = 0

    override func copy(with zone: NSZone? = nil) -> Any {

        let copied =
            super.copy(with: zone)
            as! CameraWheelLayoutAttributes

        copied.progress = progress
        copied.distance = distance

        return copied
    }

    override func isEqual(_ object: Any?) -> Bool {

        guard
            let object = object
            as? CameraWheelLayoutAttributes
        else {
            return false
        }

        if object.progress != progress {
            return false
        }
        
        if object.distance != distance {
            return false
        }

        return super.isEqual(object)
    }
    
}
