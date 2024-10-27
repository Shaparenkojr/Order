import UIKit

class ViewModel {
    var sale: Double = 0.0
    
    // кложур для передачи ошибки во ViewController
    var onError: ((String) -> Void)?
    // Метод для отображения заказа с проверками
    func showOrder(order: Order) {
        // 1. Проверка: Нет продуктов в заказе
        if order.products.isEmpty {
            onError?("В заказе отсутствуют продукты")
            return
        }
        
        // 2. Проверка: У продукта стоимость должна быть больше 0
        for product in order.products {
            if product.price <= 0 {
                onError?("У продукта \"\(product.title)\" некорректная стоимость")
                return
            }
        }
        
        // Рассчитываем сумму заказа
        let orderTotal = order.products.reduce(0) { $0 + $1.price }
        
        // 3. Проверка: Сумма текущей скидки не может быть больше суммы заказа
        if let baseDiscount = order.baseDiscount, baseDiscount > orderTotal {
            onError?("Сумма текущей скидки больше суммы заказа")
            return
        }
        
        // 4. Проверка: Сумма скидки с учетом 2х активных промокодов не может быть больше суммы заказа
        let activePromocodes = order.promocodes.filter { $0.active }
        let totalPromocodeDiscount = activePromocodes.reduce(0) { $0 + Double($1.percent) / 100 * orderTotal }
        
        if activePromocodes.count > 2 {
            onError?("Нельзя активировать более двух промокодов одновременно")
            return
        }
        
        let totalDiscount = (order.baseDiscount ?? 0) + totalPromocodeDiscount
        if totalDiscount > orderTotal {
            onError?("Сумма скидки превышает сумму заказа")
            return
        }
        
        // Если все проверки пройдены, можно продолжать с обработкой заказа
        print("Заказ корректен, отображаем данные заказа")
        // Дальнейшая логика отображения заказа
    }
    
    // Метод для обработки переключения промокода
    @objc public func promocodeSwitchToggled(_ sender: UISwitch) {
        guard let promocodeID = sender.accessibilityIdentifier else {
            print("Не удалось получить идентификатор промокода")
            return
        }
        
        // Поиск промокода по идентификатору
        if let promocode = testOrder.promocodes.first(where: { $0.title == promocodeID }) {
            if sender.isOn {
                print("Промокод \(promocode.title) активирован")
                
                // Рассчитаем сумму скидки по промокоду
                let orderTotal = testOrder.products.reduce(0) { $0 + $1.price }
                let saleAmount = Double(promocode.percent) // Процент скидки
                self.sale = orderTotal + saleAmount
//                self.sale = saleAmount * orderTotal / 100 + orderTotal   Применение скидки к общей сумме заказа
                

                
                print("Скидка по промокоду: \(sale) на сумму заказа: \(orderTotal)")
                
            } else {
                print("Промокод \(promocode.title) деактивирован")
                // Логика деактивации промокода
            }
        } else {
            print("Промокод с названием \(promocodeID) не найден")
        }
    }

}
