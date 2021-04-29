//
//  CustomerOrderTableViewCell.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit

class CustomerOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func setupUI(order: Order){
        lblOrderId.text = order.orderId
        lblCustomerName.text = order.customerName
        //lblStatus.text = order.orderStatus
        //lblTotal.text = "LKR: \(order.orderTotal)"
    }
}
