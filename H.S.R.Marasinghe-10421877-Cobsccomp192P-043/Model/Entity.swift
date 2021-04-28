//
//  Entity.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/16/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import Foundation

struct User {
    var userName: String
    var userEmail: String
    var userPassword: String
    var userPhone: String
}

struct FoodItem {
    var _id: String
    var foodName: String
    var foodDescription: String
    var foodPrice: Double
    var discount: Int
    var image: String
    var category: String
}

struct Order{
    var orderId: String = ""
    var orderStatus: String = ""
    var orderTotal: Double = 0
}

struct Category {
    var categoryName: String
}
