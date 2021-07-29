//
//  ViewController.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-24.
//

import UIKit

class CofeeOrdersViewController: UIViewController {

   
    @IBOutlet weak var orderList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coffee Orders"
        navigationController?.navigationBar.prefersLargeTitles = true
        
       
    }
    @IBAction func addToOrder(_ sender: Any) {
        performSegue(withIdentifier: "coffee", sender: nil)
        
    }


}

