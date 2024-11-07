//
//  WishStoringViewController.swift
//  sakriuchkovPW2
//
//  Created by Sergey on 06.11.2024.
//  MARK: HW-3

import UIKit

final class WishStoringViewController: UIViewController {
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    private let defaults = UserDefaults.standard
    
    enum Constants {
        static let tableCornerRadius: CGFloat = 15
        static let tableOffset: CGFloat = 10
        static let wishesKey = "wishesKey" // MARK: Ключ для сохранения пожеланий в UserDefaults
        
        static let numOfSections: Int = 2
        static let zeroSection: Int = 0
        static let oneSection: Int = 1
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        
        loadWishes()
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        
        table.dataSource = self
        
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pin(to: view, Constants.tableOffset)
        
        // MARK: Регистрируем ячейки для повторного использования
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }

    // MARK: Метод для загрузки пожеланий из UserDefaults
    private func loadWishes() {
        if let savedWishes = defaults.array(forKey: Constants.wishesKey) as? [String] {
            wishArray = savedWishes
        }
    }
    
    // MARK: Метод для сохранения пожеланий в UserDefaults
    private func saveWishes() {
        defaults.set(wishArray, forKey: Constants.wishesKey)
    }
    
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Constants.zeroSection ? Constants.oneSection : wishArray.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //MARK:  Создаем ячейку AddWishCell
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            cell.addWish = { [weak self] newWish in
                self?.wishArray.append(newWish)      // MARK: Добавляем новое пожелание в массив
                self?.saveWishes()                   // MARK: Сохраняем пожелания в UserDefaults
                self?.table.reloadData()             // MARK: Обновляем таблицу после добавления
            }
            return cell
        } else {
            // MARK: Создаем ячейку WrittenWishCell
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            cell.configure(with: wishArray[indexPath.row])
            return cell
        }
    }
}

