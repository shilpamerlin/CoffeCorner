//
//  CoffeeViewModel.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-24.
//

import Foundation
import CoreData

class CoffeeListViewModel {
    
    var result: [Order]?
   
    var coreDataObject = CoreDataStorage()
    var addCoffeDataModel = AddCoffeOrderViewModel()
    var reloadOrders: (() -> Void) = {}
    private var cellOrders = [OrderCellViewModel] () {
        didSet {
            reloadOrders()
        }
    }
    var numberOfCellOrders: Int {
        return cellOrders.count
    }
    
    func getCellRowAt(indexpath: IndexPath) -> OrderCellViewModel {
        return cellOrders[indexpath.row]
    }
    
    func getAllCoffeOrdersdata() {
         result = addCoffeDataModel.retrieveOrders()
        processFetchedOrder(result: result!)
   }
    
    func processFetchedOrder(result: [Order]) {
        var orderCellModel = [OrderCellViewModel]()
        for item in result {
            orderCellModel.append(createOrderCellViewModel(result: item))
        }
        self.cellOrders = orderCellModel
    }
    
    func createOrderCellViewModel(result: Order) -> OrderCellViewModel {
        return OrderCellViewModel(coffeName: result.coffeeName!, size: result.coffeeSize!, customerName: result.customerName!)
    }
    
    func deleteCompletedOrder(indexpath: IndexPath){
        let orderToDelete = cellOrders[indexpath.row].customerName
        let orderToRemove = cellOrders.remove(at: indexpath.row)
        coreDataObject.deleteOrder(name: orderToDelete!)
    }
}

struct OrderCellViewModel {
    let coffeName: String?
    let size: String?
    let customerName: String?
}
