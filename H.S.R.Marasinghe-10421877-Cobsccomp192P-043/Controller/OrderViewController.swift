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
    var filteredOrders: [Order] = []
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

    @IBAction func onSegChanged(_ sender: UISegmentedControl) {
        filterFood(status: "\(sender.selectedSegmentIndex)")
    }
}

extension OrderViewController {
    
    func filterFood(status: String) {
        filteredOrders.removeAll()
        filteredOrders = self.orders.filter{$0.orderStatus == status}
        tblorders.reloadData()
    }
    
    func getAllOrders() {
        self.filteredOrders.removeAll()
        self.orders.removeAll()
        self.ref.child("orders")
            .observeSingleEvent(of: .value, with: {
                snapshot in

                self.filteredOrders.removeAll()
                self.orders.removeAll()
                
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
                        self.filteredOrders.append(contentsOf: self.orders)
                        self.tblorders.reloadData()
                }
            }
                   
           }
        })
    }
}

    extension OrderViewController: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredOrders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblorders.dequeueReusableCell(withIdentifier: "CustomerOrderTableIdentifier", for: indexPath) as! CustomerOrderTableViewCell
            cell.setupUI(order: filteredOrders[indexPath.row])
            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectOrderItem = filteredOrders[indexPath.row]
        self.performSegue(withIdentifier: "OrderstoOrderItem", sender: nil)
    }
    
}

