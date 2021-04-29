//
//  CategoryTableViewCell.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblId: UILabel!
    
    var ref: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ref = Database.database().reference()
        lblId.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(foodItem: Category){
        lblCategory.text = foodItem.categoryName
        lblId.text = foodItem.categoryId
    }
    
    
    @IBAction func onDeletePressed(_ sender: UIButton) {
        //print(lblId.text)
        let ref = self.ref.child("categories")
            .child(lblId.text!)

        ref.removeValue { (error, ref) in
            if let err = error{
                print(err)
                return
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        }
    }
}
