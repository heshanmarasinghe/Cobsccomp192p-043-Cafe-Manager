//
//  OrderViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase

class OrderViewController: UIViewController {

    var orders: [Order] = []
    var selectOrderItem: Order?
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tblorders: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ref = Database.database().reference()
            tblorders.register(UINib(nibName: "CustomerOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomerOrderTableIdentifier")
        }
        
        override func viewDidAppear(_ animated: Bool) {
            getAllOrders()
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderstoOrderItem"{
            let destinationVC = segue.destination as! CustomerDetailsViewController
            destinationVC.orderItem = selectOrderItem
        }
    }

}

extension OrderViewController {
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
                                if let orderItems = orderInfo["orderItems"] as? [Any] {
                                    placedOrder.foodItems.removeAll()
                                    placedOrder.orderTotal = 0
                                    for item in orderItems {
                                        if let itemInfo = item as? [String: Any] {
                                            placedOrder.orderTotal += (itemInfo["foodPrice"] as? Double)!
                                            placedOrder.foodItems.append(((itemInfo["foodName"] as? String)!))
                                        }
                                    }
                                }
                            }
                            self.orders.append(placedOrder)
                        }
                    }
                  self.tblorders.reloadData()
                }
            }
                   
           }
        })
    }
}

    extension OrderViewController: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblorders.dequeueReusableCell(withIdentifier: "CustomerOrderTableIdentifier", for: indexPath) as! CustomerOrderTableViewCell
            cell.setupUI(order: orders[indexPath.row])
            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectOrderItem = orders[indexPath.row]
        self.performSegue(withIdentifier: "OrderstoOrderItem", sender: nil)
    }
    
}

