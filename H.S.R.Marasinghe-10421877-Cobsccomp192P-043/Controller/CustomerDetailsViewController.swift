//
//  CustomerDetailsViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase

class CustomerDetailsViewController: UIViewController {

    var ref: DatabaseReference!
    var orderItem: Order?
    
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        
        if let item = self.orderItem{
            //lblCustomerName.text = item.customerName
            lblOrderId.text = item.orderId
            lblTotal.text = "LKR: \(item.orderTotal)"
            
            lblItems.text = item.foodItems.joined(separator: "\n")
            getUserData(email: item.customerName)
         }

    }
    

    @IBAction func btnBackPressed(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
    func getUserData(email: String) {
        var user = User(userName: "", userEmail: "", userPassword: "", userPhone: "")
            ref.child("users").child(email
                .replacingOccurrences(of: "@", with: "_")
                .replacingOccurrences(of: ".", with: "_")).observe(.value, with: {
                (snapshot) in
                        
                     if snapshot.hasChildren(){
                            
                            if let data = snapshot.value{
                                if let userData = data as? [String: String]
                                {
                                     user = User(
                                        userName: userData["userName"]!,
                                        userEmail: userData["userEmail"]!,
                                        userPassword: userData["userPassword"]!,
                                        userPhone: userData["userPhone"]!)
                                    
                                    self.lblCustomerName.text =  user.userName
                                }
                            }
                   }
            })
      }
}
