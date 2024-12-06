import UIKit

final class WishCalendarViewController: UIViewController {

    enum Constants {
        static let collectionTop: CGFloat = 5
    }

    private let plusButton = UIButton(type: .system)
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private var wishEvents: [WishEventModel] = []  // Список пожеланий (событий)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configurePlusButton()
        configureCollectionView()
    }

    private func configurePlusButton() {
        plusButton.setTitle("+", for: .normal)
        plusButton.backgroundColor = .white
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        plusButton.addTarget(self, action: #selector(openEventCreationView), for: .touchUpInside)

        let plusButtonRes = UIBarButtonItem(customView: plusButton)
        navigationItem.rightBarButtonItem = plusButtonRes
    }

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        view.addSubview(collectionView)

        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        collectionView.pinLeft(to: view)
        collectionView.pinRight(to: view)
        collectionView.pinBottom(to: view)
    }

    @objc private func openEventCreationView() {
        let eventCreationVC = WishEventCreationView()
        eventCreationVC.modalPresentationStyle = .fullScreen
        present(eventCreationVC, animated: true)
    }

    // MARK: - Добавление события в коллекцию
    func addEventToCollection(_ event: WishEventModel) {
        wishEvents.append(event)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishEvents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath) as? WishEventCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: wishEvents[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
}
