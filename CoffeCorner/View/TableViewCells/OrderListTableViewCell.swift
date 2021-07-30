//
//  OrderListTableViewCell.swift
//  CoffeCorner
//
//  Created by Shilpa Joy on 2021-07-25.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var coffeName: UILabel!
    @IBOutlet weak var coffeeSize: UILabel!
    @IBOutlet weak var customerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
