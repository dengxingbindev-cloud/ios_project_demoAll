import UIKit
import SnapKit

class CameraWheelCell0: UICollectionViewCell {

    static let identifier = "CameraWheelCell0"

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
}

private extension CameraWheelCell0{
    func setupUI(){
        
        addSubview(label)

        label.snp.makeConstraints { maker in

            maker.top.equalToSuperview()
        }
    }
}

extension CameraWheelCell0{
    func configure(with item: ZoomItem) {
        label.text = item.value
    }
}

@available(iOS 17,*)
#Preview{
    CameraWheelCell0()
}
