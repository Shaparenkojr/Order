import UIKit

class ViewController: UIViewController {
    var viewModel = ViewModel()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var titleUpView: UIView = {
        let titleUpView = UIView()
        titleUpView.translatesAutoresizingMaskIntoConstraints = false
        let firstTitleLabel = UILabel()
        firstTitleLabel.text = "Оформление заказа"
        firstTitleLabel.textColor = .black
        firstTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleUpView.addSubview(firstTitleLabel)
        NSLayoutConstraint.activate([
            
            firstTitleLabel.centerXAnchor.constraint(equalTo: titleUpView.centerXAnchor),
            firstTitleLabel.centerYAnchor.constraint(equalTo: titleUpView.centerYAnchor),
        ])
        return titleUpView
        
    }()
    
    
    private lazy var upView: UIView = {
        let upView = UIView()
        upView.translatesAutoresizingMaskIntoConstraints = false
        upView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        return upView
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Промокоды"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "На один товар можно применить только один промокод"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var applyPromocodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Применить промокод", for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 0.27, alpha: 0.40)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor(red: 0.96, green: 0.38, blue: 0.10, alpha: 1.00), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    @objc func applyPromo(){
        print("")
    }
    
    
    private lazy var promocodeListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10  // Белые отступы между промокодами
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Пример промокодов с добавлением описания для первых двух
        let promocodes = [
            createPromocodeRow(title: "HELLO", discount: "\(testOrder.promocodes[0].percent)", endDate: "По 31 марта", isActive: false, descriptionText: "Промокод действует для заказов от 30 тысяч"),
            createPromocodeRow(title: "VESNA23", discount: "-5", endDate: "По 31 марта", isActive: false, descriptionText: "Промокод действует для заказов от 30 тысяч"),
            createPromocodeRow(title: "4300162112534", discount: "-5", endDate: "По 31 марта", isActive: true),
            createPromocodeRow(title: "SUMMER21", discount: "-10", endDate: "По 15 июля", isActive: false),
            createPromocodeRow(title: "NEWYEAR", discount: "-15", endDate: "По 31 декабря", isActive: false)
        ]
        
        promocodes.forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    // Секция цен
    private lazy var priceSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена за 2 товара"
        label.font = UIFont.systemFont(ofSize:16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceAmountLabel: UILabel = {
        let label = UILabel()
        let formatter = NumberFormatter()
        label.text = "\(testOrder.products[0].price + testOrder.products[1].price)  ₽"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.text = "Скидки"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var discountAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "-5 000 ₽"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var promocodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Промокоды"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var promocodeAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "-5 000 ₽"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var methodPayment: UILabel = {
        let label = UILabel()
        label.text = "Способ оплаты"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var methodPaymentAmount: UILabel = {
        let label = UILabel()
        label.text = "-5 000 ₽"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.text = "Итого: \(viewModel.sale)"
        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalLabel
    }()
    
    
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оформить заказ", for: .normal)
        button.backgroundColor = UIColor(red: 0.96, green: 0.38, blue: 0.10, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func resoultButton(){
    }
    
    private lazy var disclaimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажимая кнопку «Оформить заказ», вы соглашаетесь с Условиями оферты"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        applyPromocodeButton.addTarget(self, action: #selector(applyPromo), for: .touchUpInside)
        checkoutButton.addTarget(self, action: #selector(resoultButton), for: .touchUpInside)
    }
    
    
    
    
    private func setupUI() {
        // Добавляем scrollView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Добавляем элементы в contentView
        contentView.addSubview(titleUpView)
        
        contentView.addSubview(upView)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(applyPromocodeButton)
        contentView.addSubview(promocodeListStackView)
        
        // Добавляем секции с ценами
        contentView.addSubview(priceSectionLabel)
        contentView.addSubview(priceAmountLabel)
        contentView.addSubview(discountLabel)
        contentView.addSubview(discountAmountLabel)
        contentView.addSubview(promocodeLabel)
        contentView.addSubview(promocodeAmountLabel)
        contentView.addSubview(totalLabel)
        contentView.addSubview(checkoutButton)
        contentView.addSubview(disclaimerLabel)
        contentView.addSubview(methodPayment)
        contentView.addSubview(methodPaymentAmount)
        
        
        
        
        
        // Layout constraints для scrollView и contentView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Layout constraints для элементов внутри contentView
        NSLayoutConstraint.activate([
            
            titleUpView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleUpView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleUpView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleUpView.heightAnchor.constraint(equalToConstant: 22),
            
            
            
            
            
            upView.topAnchor.constraint(equalTo: titleUpView.bottomAnchor),
            upView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            upView.heightAnchor.constraint(equalToConstant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: upView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            applyPromocodeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            applyPromocodeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            applyPromocodeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            applyPromocodeButton.heightAnchor.constraint(equalToConstant: 50),
            
            promocodeListStackView.topAnchor.constraint(equalTo: applyPromocodeButton.bottomAnchor, constant: 20),
            promocodeListStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            promocodeListStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Цена товаров, скидки и промокоды
            priceSectionLabel.topAnchor.constraint(equalTo: promocodeListStackView.bottomAnchor, constant: 30),
            priceSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            priceAmountLabel.topAnchor.constraint(equalTo: priceSectionLabel.topAnchor),
            priceAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            discountLabel.topAnchor.constraint(equalTo: priceSectionLabel.bottomAnchor, constant: 10),
            discountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            discountAmountLabel.topAnchor.constraint(equalTo: discountLabel.topAnchor),
            discountAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            promocodeLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 10),
            promocodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            promocodeAmountLabel.topAnchor.constraint(equalTo: promocodeLabel.topAnchor),
            promocodeAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            methodPayment.topAnchor.constraint(equalTo: promocodeLabel .bottomAnchor, constant: 10),
            methodPayment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            methodPaymentAmount.topAnchor.constraint(equalTo: methodPayment.topAnchor, constant: 10),
            methodPaymentAmount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            
            
            // Итого и оформление заказа
            totalLabel.topAnchor.constraint(equalTo: methodPayment.bottomAnchor, constant: 33),
            totalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            totalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            checkoutButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 20),
            checkoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkoutButton.heightAnchor.constraint(equalToConstant: 54),
            
            disclaimerLabel.topAnchor.constraint(equalTo: checkoutButton.bottomAnchor, constant: 10),
            disclaimerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            disclaimerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            disclaimerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
//    var viewModel = ViewModel()
    

    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
        
    
    // Функция для создания строки с промокодом
    private func createPromocodeRow(title: String, discount: String, endDate: String, isActive: Bool, descriptionText: String? = nil) -> UIView {
        let container = UIView()
        
        // Устанавливаем серый фон для всех промокодов
        container.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        container.layer.cornerRadius = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let discountLabel = UILabel()
        discountLabel.text = discount
        discountLabel.font = UIFont.systemFont(ofSize: 16)
        discountLabel.textColor = .systemGreen
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let endDateLabel = UILabel()
        endDateLabel.text = endDate
        endDateLabel.font = UIFont.systemFont(ofSize: 12)
        endDateLabel.textColor = .darkGray
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = isActive
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.addTarget(viewModel, action: #selector(viewModel.promocodeSwitchToggled(_ :)), for: .valueChanged)
        toggleSwitch.accessibilityIdentifier = discount // Используем идентификатор для отслеживания промокода
        
        
        container.addSubview(titleLabel)
        container.addSubview(discountLabel)
        container.addSubview(endDateLabel)
        container.addSubview(toggleSwitch)
        
        // Создаем и добавляем описание, если оно предоставлено
        var descriptionLabel: UILabel? = nil
        if let descriptionText = descriptionText {
            descriptionLabel = UILabel()
            descriptionLabel?.text = descriptionText
            descriptionLabel?.font = UIFont.systemFont(ofSize: 12)
            descriptionLabel?.textColor = .red
            descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(descriptionLabel!)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            
            discountLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0),
            discountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
//            discountLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            endDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            endDateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            toggleSwitch.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            toggleSwitch.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            // Увеличиваем высоту контейнера, если есть описание
            container.heightAnchor.constraint(equalToConstant: descriptionLabel == nil ? 60 : 100)
        ])
        
        // Добавляем constraints для descriptionLabel, если оно есть
        if let descriptionLabel = descriptionLabel {
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 5),
                descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20)
            ])
        }
        
        return container
    }



}
