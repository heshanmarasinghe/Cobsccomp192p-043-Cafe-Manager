//
//  CategoryViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class CategoryViewController: UIViewController {

    var ref: DatabaseReference!
    
    var emptyArray = [Int]()
    var newId : Int = 0
    
    var foodItems : [Category] = []
    
    @IBOutlet weak var txtCategory: UITextField!
    
    @IBOutlet weak var tblCategory: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tblCategory.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableIdentifier")
        getMaximumFoodId()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification){
        Loaf("Category Deleted Successfully!!", state: .success, sender: self).show()
        getCategories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCategories()
    }

    @IBAction func addCategoryPressed(_ sender: UIButton) {
        addFoodItemData()
    }
    
    func getMaximumFoodId(){
         ref.child("categories").observe(.value, with: {
            (snapshot) in

            
            if let data = snapshot.value{
               
                if let foodItems = data as? [String: Any]
                {
                    for item in foodItems
                    {
                     self.emptyArray.append(Int(item.key)!)
                    }

                 let max = self.emptyArray.max()
                 self.newId = max! + 1

                 
                }
            }
        })
    }
    
     //Add Food Items
    func addFoodItemData(){

         var foodItemInfo: [String: Any] = [:]
     
         foodItemInfo["category"] = txtCategory.text
     
     ref.child("categories")
        .child("00\(self.newId)")
         .setValue(foodItemInfo)
     {
         (error, ref) in //check whether values inserted
        
         if let err = error{
             print(err)
             Loaf("Category not Saved!!", state: .error, sender: self).show()
             return
         }
         
         Loaf("Category Added Successfully!!", state: .success, sender: self).show()
     }
            self.foodItems.removeAll()
     }
}

extension CategoryViewController{
        func getCategories(){
            
            self.foodItems.removeAll()
            ref.child("categories").observe(.value, with: {
                (snapshot) in
                
                if let data = snapshot.value{
                   
                    if let foodItems = data as? [String: Any]
                    {
                        for item in foodItems
                        {
                            if let foodInfo = item.value as? [String: Any]
                            {
                                let singleFoodItem = Category(categoryId: item.key,
                                                              categoryName:foodInfo["category"] as! String)
                                                                
                                self.foodItems.append(singleFoodItem)
                            }
                        }

                        self.tblCategory.reloadData()
                    }
                }
            })
     }
    
}

extension CategoryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int{
            return foodItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCategory.dequeueReusableCell(withIdentifier: "CategoryTableIdentifier", for: indexPath) as! CategoryTableViewCell
        cell.setupView(foodItem: foodItems[indexPath.row]);
        return cell
    }
}


