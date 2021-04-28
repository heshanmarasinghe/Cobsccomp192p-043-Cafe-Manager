//
//  FoodPreviewViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase

class FoodPreviewViewController: UIViewController {

    var ref: DatabaseReference!
    
    var foodItems : [FoodItem] = []
    
    @IBOutlet weak var tblfood: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblfood.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifier")
        ref = Database.database().reference()
        getFoodItemData();
    }
    
}
    
     extension FoodPreviewViewController{
            func getFoodItemData(){
                ref.child("foodItems").observe(.value, with: {
                    (snapshot) in
                    
                    if let data = snapshot.value{
                       
                        if let foodItems = data as? [String: Any]
                        {
                            for item in foodItems
                            {
                                if let foodInfo = item.value as? [String: Any]
                                {
                                    let singleFoodItem = FoodItem(_id: "",
                                                foodName: foodInfo["name"] as! String ,
                                                foodDescription: foodInfo["description"] as! String ,
                                                foodPrice: foodInfo["price"] as! Double ,
                                                discount: foodInfo["discount"] as! Int  ,
                                                image: foodInfo["image"] as! String ,
                                                category: foodInfo["category"] as! String )
                                    
                                    
                                    self.foodItems.append(singleFoodItem)
                                }
                            }

                            self.tblfood.reloadData()
                        }
                    }
                })
         }
        
    }

    extension FoodPreviewViewController : UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
            Int{
                return foodItems.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblfood.dequeueReusableCell(withIdentifier: "FoodCellReuseIdentifier", for: indexPath) as! FoodTableViewCell
            cell.setupView(foodItem: foodItems[indexPath.row]);
            return cell
        }

    }
