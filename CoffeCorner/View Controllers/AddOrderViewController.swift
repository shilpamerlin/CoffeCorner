//
//  AddOrderViewController.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-25.
//

import UIKit

class AddOrderViewController: UIViewController {

    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var coffeeListsTblView: UITableView!
    @IBOutlet weak var customerName: UITextField!
    var coffeViewModel = AddCoffeOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeListsTblView?.dataSource = self
        coffeeListsTblView?.delegate = self
        coffeViewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.coffeeListsTblView?.reloadData()
            }
        }
        coffeViewModel.getData()
    }
    
    //MARK: - Segemented Control
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        let title = sender.titleForSegment(at: sender.selectedSegmentIndex)
        coffeViewModel.selectedSize(selectedSize: title!)
        let totalPrice = coffeViewModel.calculateTotalPrice()
        let roundedValue = round(totalPrice * 100) / 100.0
        priceLbl.text = "$" + String(roundedValue)
    }
    
    @IBAction func placeOrderBtn(_ sender: Any) {
        coffeViewModel.customerName = customerName.text
        coffeViewModel.saveOrder()
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Tableview methods
extension AddOrderViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeViewModel.numberOfCellModel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AddOrderTableViewCell
        let info = coffeViewModel.getCellAtRow(indexPath: indexPath)
        cell.coffeeName?.text = info.name
        cell.coffeImage?.image = UIImage(named: info.image)
        cell.tintColor = UIColor.brown
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            
        }
        self.coffeViewModel.selectedRow(indexPath: indexPath)
        return indexPath
    }
    
}
