//
//  AddWishCell.swift
//  sakriuchkovPW2
//
//  Created by Sergey on 06.11.2024.
//

import UIKit

// MARK: HW-3 AddWishCell
final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    enum Constants {
        static let addButtonTitle: String = "Add wish"
        
        static let wishTextViewRadius: CGFloat = 8
        static let wishTextViewBorderWidth: CGFloat = 1
        static let wishTextViewFontSize: CGFloat = 18
        
        static let wishTextViewLeading: CGFloat = 16
        static let wishTextViewTrailing: CGFloat = 16
        static let wishTextViewTop: CGFloat = 8
        static let wishTextViewHeight: CGFloat = 80
        
        static let addButtonTop: CGFloat = 8
        static let addButtonBottom: CGFloat = 8
        }
    
    // MARK: Замыкание для добавления нового пожелания
    var addWish: ((String) -> Void)?
    
    private let wishTextView: UITextView = UITextView()
    
    private let addButton: UIButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addWishTapped() {
        guard let text = wishTextView.text, !text.isEmpty else { return }
        addWish?(text)  // MARK: Вызываем замыкание, передавая введённое пожелание
        wishTextView.text = ""  // MARK: Очищаем текстовое поле после добавления
    }
    
    private func configureUI() {
        wishTextView.layer.cornerRadius = Constants.wishTextViewRadius
        wishTextView.layer.borderWidth = Constants.wishTextViewBorderWidth
        wishTextView.layer.borderColor = UIColor.lightGray.cgColor
        wishTextView.textColor = .gray
        wishTextView.font = UIFont.systemFont(ofSize: Constants.wishTextViewFontSize)
        
        addButton.setTitle(Constants.addButtonTitle, for: .normal)
        addButton.addTarget(self, action: #selector(addWishTapped), for: .touchUpInside)
        
        contentView.addSubview(wishTextView)
        contentView.addSubview(addButton)
        
        wishTextView.pinLeft(to: contentView, Constants.wishTextViewLeading)
        wishTextView.pinRight(to: contentView, Constants.wishTextViewTrailing)
        wishTextView.pinTop(to: contentView, Constants.wishTextViewTop)
        wishTextView.setHeight(Constants.wishTextViewHeight)
        
        addButton.pinTop(to: wishTextView.bottomAnchor, Constants.addButtonTop)
        addButton.pinCenterX(to: contentView)
        addButton.pinBottom(to: contentView, Constants.addButtonBottom)
        
    }
}
