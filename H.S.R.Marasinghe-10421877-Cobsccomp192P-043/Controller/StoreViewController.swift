//
//  StoreViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/26/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var category: UIView!
    @IBOutlet weak var menu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func `switch`(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            preview.isHidden = false
            category.isHidden = true
            menu.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1 {
            preview.isHidden = true
            category.isHidden = false
            menu.isHidden = true
        }
        else {
            preview.isHidden = true
            category.isHidden = true
            menu.isHidden = false
        }
    }
    
}
