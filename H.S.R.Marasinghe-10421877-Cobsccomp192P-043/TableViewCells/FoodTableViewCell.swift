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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView(foodItem: FoodItem){
        lblFoodName.text = foodItem.foodName
        lblFoodDescription.text = foodItem.foodDescription
        lblFoodPrice.text = "LKR \(foodItem.foodPrice )"
        imgFood.kf.setImage(with: URL(string: foodItem.image))
        
        if foodItem.discount > 0 {
            lblDiscount.text = "\(foodItem.discount)%"
            viewContainerDiscount.isHidden = false
        } else {
            lblDiscount.text = ""
            viewContainerDiscount.isHidden = true
        }
    }
}
