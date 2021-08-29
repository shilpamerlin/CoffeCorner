//
//  ViewController.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-24.
//

import UIKit
import CoreData
//cofeee
class CofeeOrdersViewController: UIViewController {

    @IBOutlet weak var coffeListTblView: UITableView!
    @IBOutlet weak var orderList: UITableView!
    var orderListViewModel: CoffeeListViewModel!
    
    override func viewDidLoad() {
        orderListViewModel = CoffeeListViewModel()
        super.viewDidLoad()
        coffeListTblView.delegate = self
        coffeListTblView.dataSource = self
        title = "Coffee Orders"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    //MARK: - Reloading tableview with newly created order
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        orderListViewModel.getAllCoffeOrdersdata()
        orderListViewModel.reloadOrders = { [weak self] () in
             DispatchQueue.main.async {
                 self!.coffeListTblView.reloadData()
             }
        }
    }

    @IBAction func addToOrder(_ sender: Any) {
       performSegue(withIdentifier: "coffee", sender: nil)
    }
}

//MARK: - Tableview methods
extension CofeeOrdersViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListViewModel.numberOfCellOrders
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! OrderListTableViewCell
        let info = orderListViewModel.getCellRowAt(indexpath: indexPath)
        cell.coffeName.text = info.coffeName
        cell.coffeeSize.text = info.size
        cell.customerName.text = "Ordered by: " + info.customerName!
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Tableview method to delete completed order while trailingswipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Completed") { (action, view, completionHandler) in
            self.orderListViewModel.deleteCompletedOrder(indexpath: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
