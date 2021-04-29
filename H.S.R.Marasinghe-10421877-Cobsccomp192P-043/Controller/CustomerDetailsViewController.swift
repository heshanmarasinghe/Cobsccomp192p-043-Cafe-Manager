//
//  CustomerDetailsViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit

class CustomerDetailsViewController: UIViewController {

    
    var orderItem: Order?
    
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = self.orderItem{
            lblCustomerName.text = item.customerName
            lblOrderId.text = item.orderId
            lblTotal.text = "LKR: \(item.orderTotal)"
            
            lblItems.text = item.foodItems.joined(separator: "\n")
         }

    }
    

    @IBAction func btnBackPressed(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
}
