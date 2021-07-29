//
//  AddCoffeOrderViewModel.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-26.
//

import Foundation
import UIKit

class AddCoffeOrderViewModel: ObservableObject {
    
   
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
    func getCellAtRow(indexPath: IndexPath) -> CoffeCellModel {
        return cellViewModel[indexPath.row]
    }
    var total: Double {
        return calculateTotalPrice()
    }
    var reloadTableViewClosure: (() -> Void) = {}
    
    @Published var size: String = ""
    @Published var coffeName: String = ""

    func getData() {
         result = coffeDataModel.addCoffee()
        print("result is \(result)")
        processFetchedData(coffeList: result!)
    }
    func processFetchedData(coffeList: [Coffee]){
        var cellModel = [CoffeCellModel]()
        for item in coffeList {
           // print("item is \(item)")
            cellModel.append(createCellViewModel(coffeeList: item))
            
        }
        self.cellViewModel = cellModel
    }
    
    func createCellViewModel(coffeeList: Coffee) -> CoffeCellModel {
        return CoffeCellModel(name: coffeeList.name!, image: coffeeList.imageURL!, price: coffeeList.price!)
    }
    
    private func priceForSize() -> Double {
        let prices = ["Small": 2.0, "Medium": 3.0, "Large": 4.0]
        guard let price = prices[self.size] else {
            return 0.0
        }
        return price
    }
    
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
}

struct CoffeCellModel {
    let name: String
    let image: String
    let price: Double
}