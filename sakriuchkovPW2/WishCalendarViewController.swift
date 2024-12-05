//
//  Untitled.swift
//  sakriuchkovPW2
//
//  Created by Sergey on 05.12.2024.
//

import UIKit

final class WishCalendarViewController: UIViewController {
    
    enum Constants {
        static let contentInset: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
        static let collectionTop: CGFloat = 16
    }
    
    private let plusButton = UIButton(type: .system)
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePlusButton()
        confugureCollection()
    }
    
    private func configurePlusButton() {
        view.addSubview(plusButton)
        
        plusButton.setTitle("+", for: .normal)
        plusButton.backgroundColor = .systemGray5
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        plusButton.addTarget(self, action: #selector(openEventCreationView), for: .touchUpInside)
        
        plusButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 50)
        plusButton.pinRight(to: view, 50)
    }
    
    private func confugureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: plusButton.bottomAnchor, Constants.collectionTop)

    }
    
    // MARK: HW-4
    @objc private func openEventCreationView() {
        let eventCreationVC = WishEventCreationView()
        present(eventCreationVC, animated: true)
    }
}

extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView (
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
            return 10
        }
    
    func collectionView (
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView (
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
    
    func collectionView(
        _collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
