//
//  MealListViewModel.swift
//  Recipe App
//
//  Copyright © 2023 TaeVon Lewis. All rights reserved.
//


import SwiftUI

@Observable
class MealListViewModel {
    var meals: [MealList] = []
    var mealCategories: [String: Category] = [:]
    var fetchError: Error?

    /// Fetches a list of meals from the API and updates the `meals` property.
    func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.fetchError = error
                }
                return
            }
            
            do {
                guard let data = data else { throw URLError(.badServerResponse) }
                let mealResponse = try JSONDecoder().decode([String: [MealList]].self, from: data)
                guard let meals = mealResponse["meals"] else { throw URLError(.cannotParseResponse) }
                
                DispatchQueue.main.async {
                    self?.meals = meals.sorted { $0.strMeal < $1.strMeal }
                    self?.fetchError = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self?.fetchError = error
                }
            }
        }

        task.resume()
    }
    
    func fetchCategory(for mealID: String) {
        let categoryURL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)")!

        let task = URLSession.shared.dataTask(with: categoryURL) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.fetchError = error
                }
                return
            }

            do {
                // Decode the JSON response into a Category object
                let jsonResponse = try JSONDecoder().decode([String: [Category]].self, from: data)
                if let categories = jsonResponse["meals"], let category = categories.first {
                    DispatchQueue.main.async {
                        self?.mealCategories[mealID] = category
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.fetchError = error
                }
            }
        }
        task.resume()
    }
}
