//
//  order.swift
//  product order
//
//  Created by Тарас Шапаренко on 22.10.2024.
//
import Foundation

public struct Order {

    struct Promocode {

        let title: String

        let percent: Int

        let endDate: Date?

        let info: String?

        let active: Bool

    }

    

    struct Product {

        let price: Double

        let title: String

    }

    var screenTitle: String

    var promocodes: [Promocode]

    

    let products: [Product]

    let paymentDiscount: Double?

    let baseDiscount: Double?

}



let testOrder = Order(
    screenTitle: "Ваш заказ",
    promocodes: [
        Order.Promocode(
            title: "5",
            percent: 5,
            endDate: Calendar.current.date(byAdding: .day, value: 10, to: Date()),
            info: "Скидка 5% на все товары",
            active: true
        ),
        Order.Promocode(
            title: "Промокод на 10%",
            percent: 10,
            endDate: Calendar.current.date(byAdding: .day, value: 20, to: Date()),
            info: "Скидка 10% на определенные товары",
            active: false
        )
    ],
    products: [
        Order.Product(price: 5000.0, title: "Товар 1"),
        Order.Product(price: 5000.0, title: "Товар 2")
    ],
    paymentDiscount: 50.0,
    baseDiscount: 30.0
)
