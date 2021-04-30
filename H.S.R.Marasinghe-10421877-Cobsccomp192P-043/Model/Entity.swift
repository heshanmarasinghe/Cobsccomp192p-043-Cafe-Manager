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
    var isActive: Bool
}

struct Order{
    var customerName: String = ""
    var orderId: String = ""
    var orderStatus: String = ""
    var foodPrice: [String] = []
    var orderTotal: Double = 0
    var foodItems: [String] = []
    var date: String = ""
}

struct Category {
    var categoryId: String
    var categoryName: String
}
