//
//  MealList.swift
//  Recipe App
//
//  Copyright © 2023 TaeVon Lewis. All rights reserved.
//


import SwiftUI

@Observable
class MealList: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL

    var id: String { idMeal }
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
    }
    
    init(idMeal: String, strMeal: String, strMealThumb: URL) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(URL.self, forKey: .strMealThumb)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strMealThumb, forKey: .strMealThumb)
    }
}
