//
//  OrderItemsTableViewCell.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/28/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit

class OrderItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblItems: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView(orderItems: [String]){
        lblItems.text = orderItems[0]
    }
}
