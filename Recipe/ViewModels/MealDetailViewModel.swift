//
//  MealDetailViewModel.swift
//  Recipe App
//
//  Copyright © 2023 TaeVon Lewis. All rights reserved.
//


import SwiftUI

@Observable
class MealDetailViewModel {
    var mealDetail: MealDetail?
    var fetchError: Error?

    /// Fetches the details of a meal identified by `mealID`.
    /// - Parameter mealID: The unique identifier for the meal whose details are to be fetched.
    func fetchMealDetail(mealID: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.fetchError = error
                }
                return
            }
            
            do {
                guard let data = data else { throw URLError(.badServerResponse) }
                let mealResponse = try JSONDecoder().decode([String: [MealDetail]].self, from: data)
                guard let details = mealResponse["meals"]?.first else { throw URLError(.cannotParseResponse) }
                
                DispatchQueue.main.async {
                    self?.mealDetail = details
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
}
