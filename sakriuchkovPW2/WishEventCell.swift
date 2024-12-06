import UIKit

final class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier = "WishEventCell"
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let startDateLabel = UILabel()
    private let endDateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(startDateLabel)
        contentView.addSubview(endDateLabel)
        
        // Настроить constraints для элементов
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start: \(event.startDate)"
        endDateLabel.text = "End: \(event.endDate)"
    }
}
