//
//  MenuViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class MenuViewController: UIViewController {

    var ref: DatabaseReference!
    
    var emptyArray = [Int]()
    var newId : Int = 0
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtDiscount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getMaximumFoodId()
    }
    
    @IBAction func addItemPressed(_ sender: UIButton) {
        addFoodItemData()
    }
    
    func getMaximumFoodId(){
         ref.child("foodItems").observe(.value, with: {
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
        foodItemInfo["description"] = txtDescription.text
    foodItemInfo["discount"] = Int(txtDiscount.text!)
        foodItemInfo["image"] = "https://firebasestorage.googleapis.com/v0/b/cafenibm-b7391.appspot.com/o/foodItems%2Fsandwich.png?alt=media&token=359595a3-33e4-4987-b959-3b8aa6202e57"
        foodItemInfo["name"] = txtName.text
        foodItemInfo["price"] = Int(txtPrice.text!)
    
    ref.child("foodItems")
        .child("00\(self.newId)")
        .setValue(foodItemInfo)
    {
        (error, ref) in //check whether values inserted
       
        if let err = error{
            print(err)
            Loaf("Item not Saved!!", state: .error, sender: self).show()
            return
        }
        
        Loaf("Item Saved Successfully!!", state: .success, sender: self).show() {
            type in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    }
}
