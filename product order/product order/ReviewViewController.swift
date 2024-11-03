//
//  ReviewViewController.swift
//  product order
//
//  Created by Тарас Шапаренко on 29.10.2024.
//

import UIKit


class ReviewViewController: UIViewController {
    
    // Создаем экземпляр ViewModel
    private let viewModel = ReviewViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewTableCell.self, forCellReuseIdentifier: String(describing: NewTableCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Напишите отзыв"
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
                    tableView.widthAnchor.constraint(equalToConstant: 335),
                    tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
    }
}


extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    // Количество секций теперь равно количеству элементов
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }
    
    // В каждой секции будет только одна ячейка
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewTableCell.self)) as? NewTableCell else {
            fatalError("Не удалось создать ячейку")
        }
        let item = viewModel.items[indexPath.section] // Получаем данные для текущей секции
        cell.configure(with: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79.75
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
    // Переход при нажатии на ячейку
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedItem = viewModel.items[indexPath.section]
            let detailViewController = DetailViewController()
            detailViewController.selectedItem = selectedItem // Передаем данные выбранной ячейки
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    class NewTableCell: UITableViewCell {
        
        private let itemImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .black
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let accessoryImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
            imageView.tintColor = .gray
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) не реализован")
        }
        
        private func setupViews() {
            contentView.addSubview(itemImageView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(accessoryImageView)
            
            NSLayoutConstraint.activate([
                itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                itemImageView.widthAnchor.constraint(equalToConstant: 79.75),
                itemImageView.heightAnchor.constraint(equalToConstant: 79.75),
                
                titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
                titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor, constant: -8),
                
                accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
                accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
        
        // Метод для настройки содержимого ячейки
        func configure(with item: ReviewItem, showAccssory: Bool = true) {
            titleLabel.text = item.title
            itemImageView.image = UIImage(named: item.imageName)
            accessoryImageView.isHidden = !showAccssory
        }
    }

