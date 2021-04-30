//
//  FoodTableViewCell.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    
    @IBOutlet weak var viewContainerDiscount: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var switchFoodStatus: UISwitch!
    
    var delegate: FoodItemCellAction?
    var foodItem: FoodItem?
    var rowIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView(foodItem: FoodItem, index: Int){
        lblFoodName.text = foodItem.foodName
        lblFoodDescription.text = foodItem.foodDescription
        lblFoodPrice.text = "LKR \(foodItem.foodPrice )"
        imgFood.kf.setImage(with: URL(string: foodItem.image))
        switchFoodStatus.isOn = foodItem.isActive
        
        if foodItem.discount > 0 {
            lblDiscount.text = "\(foodItem.discount)%"
            viewContainerDiscount.isHidden = false
        } else {
            lblDiscount.text = ""
            viewContainerDiscount.isHidden = true
        }
        
        self.rowIndex = index
        self.foodItem = foodItem
    }
    

    @IBAction func onFoodStatusChanged(_ sender: UISwitch) {
        self.delegate?.onFoodItemStatusChanged(foodItem: self.foodItem!, status: sender.isOn)
    }
}

protocol FoodItemCellAction {
    func onFoodItemStatusChanged(foodItem: FoodItem, status: Bool)
}
