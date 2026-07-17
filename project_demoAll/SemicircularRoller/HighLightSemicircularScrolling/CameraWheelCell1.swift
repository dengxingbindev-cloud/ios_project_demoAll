import UIKit
import SnapKit

class CameraWheelCell1: UICollectionViewCell {

    static let identifier = "CameraWheelCell1"

    private lazy var label: UILabel = {

        let label = UILabel()

        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()

    override init(frame: CGRect) {

            super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) {
        super.apply(layoutAttributes)

        guard let attributes =
        layoutAttributes as? CameraWheelLayoutAttributes
        else {
            return
        }

        updateAppearance(
            progress: attributes.progress,
            distance: attributes.distance
        )
    }
    
}

private extension CameraWheelCell1{
    func setupUI(){
        
        addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension CameraWheelCell1{
    func configure(with item: ZoomItem) {
        label.text = item.value
    }
}

extension CameraWheelCell1{
    
    private func interpolate(
        progress: CGFloat,
        min: CGFloat,
        max: CGFloat
    ) -> CGFloat {
        min + (max - min) * progress
    }
    
    private func updateAppearance(
        progress: CGFloat,

        distance: CGFloat

    ) {

        let scale = interpolate(
            progress: progress,
            min: 0.8,
            max: 1.2
        )

        let radius: CGFloat = 250

        let x = min(distance, radius)

        let y = sqrt(radius * radius - x * x)

        let offsetY = radius - y

        let fontSize = interpolate(
            progress: progress,
            min: 18,
            max: 26
        )

        transform = CGAffineTransform.identity
            .translatedBy(x: 0, y: offsetY)
            .scaledBy(x: scale, y: scale)

        label.font = .systemFont(
            ofSize: fontSize,
            weight: .semibold
        )

        label.alpha = interpolate(
            progress: progress,
            min: 0.4,
            max: 1.0
        )
        
        let value = progress * 0.6

        label.textColor = UIColor(
            red: 1,
            green: value,
            blue: 0,
            alpha: 1
        )
    }
}

@available(iOS 17,*)
#Preview{
    CameraWheelCell1()
}
