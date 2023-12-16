//
//  Category.swift
//  Recipe App
//
//  Copyright © 2023 TaeVon Lewis. All rights reserved.
//


import SwiftUI

class Category: Codable {
    var idMeal: String
    var strMeal: String
    var strCategory: String

    enum CodingKeys: String, CodingKey {
        case idMeal = "idMeal"
        case strMeal = "strMeal"
        case strCategory = "strCategory"
    }
    
    init(idMeal: String, strMeal: String, strCategory: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strCategory = strCategory
    }
}
