//
//  Coffee.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-26.
//

import Foundation

struct Coffee {
    var name: String?
    var imageURL: String?
    var price: Double?
    var coffeList = [Coffee]()
    /*let coffeList = [
        Coffee(name: "Cappuccino", imageURL: "capuccino", price: 2.5),
        Coffee(name: "Latte", imageURL: "latte", price: 2.1),
        Coffee(name: "Black Tea", imageURL: "black", price: 1.0)
    ]*/
    
    mutating func addCoffee() -> [Coffee]
    {
        var obj1 = Coffee(name: "Cappuccino", imageURL: "capuccino", price: 2.5)
        coffeList.append(obj1)
        
        var obj2 = Coffee(name: "Latte", imageURL: "latte", price: 2.1)
        coffeList.append(obj2)
        
        var obj3 = Coffee(name: "Black Tea", imageURL: "black", price: 1.0)
        coffeList.append(obj3)
        
        return coffeList
    }
}
