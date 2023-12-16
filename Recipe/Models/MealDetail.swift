//
//  MealDetail.swift
//  Recipe App
//
//  Copyright © 2023 TaeVon Lewis. All rights reserved.
//


import SwiftUI

@Observable
class MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    var ingredients: [String: String?] = [:]

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        idMeal = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "idMeal")!)
        strMeal = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strMeal")!)
        strInstructions = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strInstructions")!)

        for i in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)")
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)")

            if let ingredientKey = ingredientKey, let measureKey = measureKey,
               let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.isEmpty {
                let measure = try container.decodeIfPresent(String.self, forKey: measureKey)
                ingredients[ingredient] = measure
            }
        }
    }
}
