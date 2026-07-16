import UIKit
import SnapKit

class CameraWheelCell: UICollectionViewCell {

    static let identifier = "CameraWheelCell"

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

private extension CameraWheelCell{
    func setupUI(){
        
        addSubview(label)

        label.snp.makeConstraints { maker in

            maker.top.equalToSuperview()
        }
    }
}

extension CameraWheelCell{
    func configure(with item: ZoomItem) {
        label.text = item.value
    }
}

@available(iOS 17,*)
#Preview{
    CameraWheelCell()
}
