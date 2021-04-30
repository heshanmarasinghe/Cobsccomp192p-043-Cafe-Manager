//
//  AccountViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    var orders: [Order] = []
    var filteredOrders: [Order] = []
    let sessionMGR = SessionManager()
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var txtstartDate: UITextField!
    
    @IBOutlet weak var tblorders: UITableView!
    
    let startDate = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
            tblorders.register(UINib(nibName: "AccountOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountOrdersTableIdentifier")
        createDatePicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllOrders()
    }

    @IBAction func onSignOutPressed(_ sender: UIButton) {
        sessionMGR.clearUserLoggedState()
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([donebtn], animated: true)
        
        txtstartDate.inputAccessoryView = toolbar
        txtstartDate.inputView = startDate
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        txtstartDate.text = formatter.string(from: startDate.date)
        self.view.endEditing(true)
    }
}

extension AccountViewController {
    func filterFood(){
    }
    
    
    func getAllOrders() {
                
        self.orders.removeAll()
        self.ref.child("orders")
            .observe(.value, with: {
                snapshot in

                if let data = snapshot.value {
                    var placedOrder = Order()
                    
                    if let users = data as? [String: Any] {
                    for user in users {
                        placedOrder.customerName = user.key
                        if let orders = user.value as? [String: Any] {
                        for singleOrder in orders {
                            placedOrder.orderId = singleOrder.key
                            if let orderInfo = singleOrder.value as? [String: Any] {
                                placedOrder.orderStatus = orderInfo["status"] as! String
                                placedOrder.date = orderInfo["Date"] as! String
                                if let orderItems = orderInfo["orderItems"] as? [Any] {
                                    placedOrder.foodItems.removeAll()
                                    placedOrder.orderTotal = 0
                                    placedOrder.foodPrice.removeAll()
                                    for item in orderItems {
                                        if let itemInfo = item as? [String: Any] {
                                            placedOrder.foodPrice.append((("\(itemInfo["foodPrice"] ?? "")")))
                                            placedOrder.orderTotal += (itemInfo["foodPrice"] as? Double)!
                                            placedOrder.foodItems.append(((itemInfo["foodName"] as? String)!))
                                        }
                                    }
                                }
                            }
                            self.orders.append(placedOrder)
                        }
                    }
                        //placedOrder.customerName = self.userName
                  self.tblorders.reloadData()
                }
                 }
                }
            })
    }
}


    extension AccountViewController: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblorders.dequeueReusableCell(withIdentifier: "AccountOrdersTableIdentifier", for: indexPath) as! AccountOrdersTableViewCell
            cell.setupUI(order: orders[indexPath.row])
            return cell
    }
    
}
