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
    
    //MARK:- Method to store order details to Core Data
    func saveToCoredata(name: String, custName: String, size: String){
        let newOrder = Order(context: self.context)
        newOrder.id = UUID()
        newOrder.coffeeName = name
        newOrder.customerName = custName
        newOrder.coffeeSize = size
    
        do {
           try self.context.save()
        }
        catch {
            print("Error ocuured while saving")
        }
    }
    
    //MARK:- Method to retrieve data from Core Data
    func fetchData() -> [Order] {
        do {
            let request = Order.fetchRequest() as NSFetchRequest <Order>
           // let sort = NSSortDescriptor(key: "customerName")
           // request.sortDescriptors = [sort]
            self.order = try context.fetch(request)
        } catch {
            print("Error retreiving data from Core Data")
        }
        return order!
    }
    
    //MARK:- Method to delete completed order from Core Data
    func deleteOrder(name: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Order")
        fetchRequest.predicate = NSPredicate(format: "customerName = %@", "\(name)")
        do
            {
                let fetchedResults =  try context.fetch(fetchRequest) as? [NSManagedObject]
                for entity in fetchedResults! {
                    context.delete(entity)
                    do
                    {
                        try context.save()
                    }
                    catch let error as Error?
                    {
                        print(error!.localizedDescription)
                    }
                }
            }
            catch _ {
                print("Could not delete")
            }
        self.fetchData()
        }
}
