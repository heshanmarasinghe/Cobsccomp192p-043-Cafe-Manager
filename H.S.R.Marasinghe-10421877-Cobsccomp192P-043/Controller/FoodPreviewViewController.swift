//
//  FoodPreviewViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class FoodPreviewViewController: UIViewController {

    var ref: DatabaseReference!
    
    var foodItems : [FoodItem] = []
    var categoryList : [Category] = []
    var filteredFoodItems : [FoodItem] = []
    var selectedCategoryIndex = 0
    
    @IBOutlet weak var tblfood: UITableView!
    
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblfood.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifier")
        collectionViewCategories.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewIdentifier")
        ref = Database.database().reference()
        //getCategories()
        //getFoodItemData();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCategories()
        getFoodItemData()
    }
}
    
     extension FoodPreviewViewController{
        func changeFoodStatus(foodItem: FoodItem, status: Bool){
            ref.child("foodItems")
                .child(foodItem._id)
                .child("isActive")
                .setValue(status){
                    (error, ref) in
                    
                     if let err = error{
                         print(err)
                         Loaf("Status Change Error!!", state: .error, sender: self).show()
                         return
                     }
                    Loaf("Status Changed!!", state: .success, sender: self).show()
            }
            
        }
            func getFoodItemData(){
                self.foodItems.removeAll()
                self.filteredFoodItems.removeAll()
                ref.child("foodItems").observeSingleEvent(of: .value, with: {
                    (snapshot) in
                    
                    if let data = snapshot.value{
                       
                        if let foodItems = data as? [String: Any]
                        {
                            for item in foodItems
                            {
                                if let foodInfo = item.value as? [String: Any]
                                {
                                    let singleFoodItem = FoodItem(_id: item.key,
                                                foodName: foodInfo["name"] as! String ,
                                                foodDescription: foodInfo["description"] as! String ,
                                                foodPrice: foodInfo["price"] as! Double ,
                                                discount: foodInfo["discount"] as! Int  ,
                                                image: foodInfo["image"] as! String ,
                                                category: foodInfo["category"] as! String,
                                                isActive: foodInfo["isActive"] as! Bool)
                                    
                                    
                                    self.foodItems.append(singleFoodItem)
                                }
                            }

                            self.filteredFoodItems.append(contentsOf: self.foodItems)
                            self.tblfood.reloadData()
                        }
                    }
                })
         }
        
    }


extension FoodPreviewViewController : UITableViewDelegate, UITableViewDataSource, FoodItemCellAction {
    func onFoodItemStatusChanged(foodItem: FoodItem, status: Bool) {
        self.changeFoodStatus(foodItem: foodItem, status: status)
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
            Int{
                return filteredFoodItems.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblfood.dequeueReusableCell(withIdentifier: "FoodCellReuseIdentifier", for: indexPath) as! FoodTableViewCell
            cell.delegate = self
            cell.setupView(foodItem: filteredFoodItems[indexPath.row], index: indexPath.row);
            return cell
        }

    }

    extension FoodPreviewViewController {
        func filterFood(category: Category){
            filteredFoodItems = foodItems.filter{$0.category == category.categoryName}
            tblfood.reloadData()
        }
        
          func getCategories(){
               
               self.categoryList.removeAll()
            ref.child("categories").observeSingleEvent(of: .value, with: {
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
                                                                   
                                   self.categoryList.append(singleFoodItem)
                               }
                           }

                           self.collectionViewCategories.reloadData()
                       }
                   }
               })
        }
    }
    

extension FoodPreviewViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewCategories.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewIdentifier",
                                         for: indexPath) as! CategoryCollectionViewCell
        cell.configXIB(category: categoryList[indexPath.row]);
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.row
        UIView.transition(with: collectionViewCategories, duration: 0.3, options: .transitionCrossDissolve, animations: {self.collectionViewCategories.reloadData()}, completion: nil)
        
        filterFood(category: categoryList[indexPath.row]);
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: CategoryCollectionViewCell = Bundle.main.loadNibNamed("CategoryCollectionViewCell", owner: self, options: nil)?.first as? CategoryCollectionViewCell else {
            return CGSize.zero
        }
        
        cell.configXIB(category: categoryList[indexPath.row]);
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 30)
    }
    
  }
