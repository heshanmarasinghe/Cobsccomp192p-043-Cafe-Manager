//
//  CategoryCollectionViewCell.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/30/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configXIB(category: Category)    {
        lblCategory.text = category.categoryName
    }
}
