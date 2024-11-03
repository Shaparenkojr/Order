//
//  DetailViewController.swift
//  product order
//
//  Created by Тарас Шапаренко on 01.11.2024.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedItem: ReviewItem? // Данные из выбранной ячейки

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewTableCell.self, forCellReuseIdentifier: String(describing: NewTableCell.self))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Напишите отзыв"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalToConstant: 335),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6 // Количество секций для каждой отдельной ячейки
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // Первая ячейка — выбранный элемент
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewTableCell.self)) as? NewTableCell, let item = selectedItem else {
                return UITableViewCell()
            }
            cell.configure(with: item, showAccssory: false)
            cell.accessoryType = .none
            return cell
            
        case 1:
            // Рейтинг
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "Рейтинг"
            // Добавьте здесь ваш рейтинг (например, звезды)
            return cell
            
        case 2:
            // Добавить фото или видео
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "Добавьте фото или видео"
            return cell
            
        case 3:
            // Достоинства
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "Достоинства"
            return cell
            
        case 4:
            // Недостатки
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "Недостатки"
            return cell
            
        case 5:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "Комментарий"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80 // Высота для выбранного элемента
        case 1...5:
            return 50 // Высота для остальных ячеек
        default:
            return UITableView.automaticDimension
        }
    }
}
