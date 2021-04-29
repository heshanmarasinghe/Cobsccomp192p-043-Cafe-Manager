//
//  AccountOrdersTableViewCell.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit

class AccountOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(order: Order){
        lblDate.text = order.date
        lblItems.text = order.foodItems.joined(separator: "\n")
        lblPrice.text = order.foodPrice.joined(separator: "\n")
        lblTotal.text = "LKR: \(order.orderTotal)"
    }
    
}
