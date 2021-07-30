//
//  Order+CoreDataProperties.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-29.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var coffeeSize: String?
    @NSManaged public var coffeeName: String?
    @NSManaged public var customerName: String?

}

extension Order : Identifiable {

}
