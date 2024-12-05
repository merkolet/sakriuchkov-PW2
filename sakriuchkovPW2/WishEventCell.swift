//
//  Untitled.swift
//  sakriuchkovPW2
//
//  Created by Sergey on 06.12.2024.
//

import UIKit

final class WishEventCell : UICollectionViewCell {
    
    struct WishEventModel {
        let title: String
        let description: String
        let startDate: String
        let endDate: String
    }
    
    enum Constants {
        static let offset: CGFloat = 10
        static let cornerRadius: CGFloat = 12
        static let backgroundColor: UIColor = .systemBlue
        
        static let titleTop: CGFloat = 10
        static let titleFont: UIFont = .systemFont(ofSize: 16)
        static let titleLeading: CGFloat = 15
        
        static let descriptionTop: CGFloat = 5
        static let descriptionFont: UIFont = UIFont.systemFont(ofSize: 14)
        
        static let dateTop: CGFloat = 8
        static let dateFont: UIFont = UIFont.systemFont(ofSize: 12)
        
        
    }
    
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    private func configureWrap() {
        addSubview(wrapView)
        
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
        descriptionLabel.pinLeft(to: wrapView, Constants.titleLeading)
        descriptionLabel.pinRight(to: wrapView, Constants.titleLeading)
    }
    
    private func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        
        startDateLabel.textColor = .gray
        startDateLabel.font = Constants.dateFont
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, Constants.dateTop)
        startDateLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        
        endDateLabel.textColor = .gray
        endDateLabel.font = Constants.dateFont
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.dateTop)
        endDateLabel.pinLeft(to: wrapView, Constants.titleLeading)
        endDateLabel.pinBottom(to: wrapView, Constants.titleTop)
    }
}
