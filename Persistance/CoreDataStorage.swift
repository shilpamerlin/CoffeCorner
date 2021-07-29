//
//  CoreDataStorage.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-25.
//

import Foundation
import CoreData
import UIKit

class CoreDataStorage: NSManagedObject {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var order: [Order]?
    
    func saveToCoredata(){
        let latte = Order(context: self.context)
        latte.name = "Latte"
        
    }
    
}
