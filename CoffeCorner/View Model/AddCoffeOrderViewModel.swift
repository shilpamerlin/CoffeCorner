//
//  AddCoffeOrderViewModel.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-26.
//

import Foundation
import UIKit

class AddCoffeOrderViewModel: ObservableObject {
    
    var coreDataObj = CoreDataStorage()
    var customerName: String?
    var coffeDataModel = Coffee()
    var result: [Coffee]?
    var selectedItem: CoffeCellModel?
    private var cellViewModel = [CoffeCellModel]() {
        didSet {
            reloadTableViewClosure()
        }
    }
    var numberOfCellModel: Int {
        return cellViewModel.count
    }
    var total: Double {
        return calculateTotalPrice()
    }
    var reloadTableViewClosure: (() -> Void) = {}
    @Published var size: String = ""
    @Published var coffeName: String = ""
    
    func getCellAtRow(indexPath: IndexPath) -> CoffeCellModel {
        return cellViewModel[indexPath.row]
    }
   
    func getData() {
         result = coffeDataModel.addCoffee()
         processFetchedData(coffeList: result!)
    }
    
    func processFetchedData(coffeList: [Coffee]){
        var cellModel = [CoffeCellModel]()
        for item in coffeList {
            cellModel.append(createCellViewModel(coffeeList: item))
        }
        self.cellViewModel = cellModel
    }
    
    func createCellViewModel(coffeeList: Coffee) -> CoffeCellModel {
        return CoffeCellModel(name: coffeeList.name!, image: coffeeList.imageURL!, price: coffeeList.price!)
    }
    
    //MARK: - Method shows prices for different coffee size
    private func priceForSize() -> Double {
        let prices = ["Small": 2.0, "Medium": 3.0, "Large": 4.0]
        guard let price = prices[self.size] else {
            return 0.0
        }
        return price
    }
    
    //MARK: - Method to calculate coffee price based on size choosen
    func calculateTotalPrice() -> Double {
    let coffeViewModel = result!.first(where: { $0.name == coffeName})
        if let coffeViewModel = coffeViewModel {
            print(coffeViewModel.price! * priceForSize())
            return coffeViewModel.price! * priceForSize()
            
        } else {
            return 0.0
        }
    }

    func selectedRow(indexPath: IndexPath){
        selectedItem = cellViewModel[indexPath.row]
        coffeName = selectedItem!.name
    }
    
    func selectedSize(selectedSize: String) {
        size = selectedSize
    }
    
    func retrieveOrders() -> [Order] {
        let retrievedData = coreDataObj.fetchData()
        return retrievedData
    }
    
    func saveOrder() {
        coreDataObj.saveToCoredata(name: selectedItem!.name, custName: customerName!, size: size)
    }
   
}

struct CoffeCellModel {
    let name: String
    let image: String
    let price: Double
}
