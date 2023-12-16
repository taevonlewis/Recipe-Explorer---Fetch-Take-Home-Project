//
//  MealListView.swift
//  Recipe App
//
//  Copyright © 2023 TaeVon Lewis. All rights reserved.
//


import SwiftUI

struct MealListViewConstants {
    static let listRowSpacing: CGFloat = 20
    static let imageHeight: CGFloat = 100
    static let imageCornerRadius: CGFloat = 10
    static let imageStrokeLineWidth: CGFloat = 0.5
    static let vStackLeadingPadding: CGFloat = 10
    static let rowVerticalPadding: CGFloat = 10
    static let rowHorizontalPadding: CGFloat = 10
    static let rowCornerRadius: CGFloat = 12
    static let rowShadowOpacity: Double = 0.1
    static let rowShadowRadius: CGFloat = 5
    static let placeholderOpacity: Double = 0.3
}

struct MealListView: View {
    @State var viewModel = MealListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                let category = viewModel.mealCategories[meal.idMeal] ?? Category(idMeal: "", strMeal: "", strCategory: "Loading...")
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal, mealImageURL: meal.strMealThumb)) {
                    MealRowView(meal: meal, category: category)
                }
                .listRowBackground(Color.clear)
                .onAppear {
                    if viewModel.mealCategories[meal.idMeal] == nil {
                        viewModel.fetchCategory(for: meal.idMeal)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Dessert Recipes")
            .onAppear {
                viewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    MealListView()
}
