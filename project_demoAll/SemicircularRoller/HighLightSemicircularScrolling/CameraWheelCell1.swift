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
}

private extension CameraWheelCell1{
    func setupUI(){
        
        addSubview(label)

        label.snp.makeConstraints { maker in

            maker.top.equalToSuperview()
        }
    }
}

extension CameraWheelCell1{
    func configure(
        with item: ZoomItem,
        isSelected: Bool
    ) {

        label.text = item.value

        if isSelected {

            label.textColor = .systemYellow
            label.font = .boldSystemFont(ofSize: 24)

        } else {

            label.textColor = .lightGray
            label.font = .systemFont(ofSize: 18)

        }
    }
}

@available(iOS 17,*)
#Preview{
    CameraWheelCell1()
}
