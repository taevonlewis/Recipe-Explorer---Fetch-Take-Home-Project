//
//  MealRowView.swift
//  Recipe App
//
//  Copyright © 2023 TaeVon Lewis. All rights reserved.
//


import SwiftUI

struct MealRowView: View {
    let meal: MealList
    let category: Category
    
    var body: some View {
        HStack(spacing: MealListViewConstants.listRowSpacing) {
            AsyncImage(url: meal.strMealThumb) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(MealListViewConstants.placeholderOpacity)
            }
            .frame(width: MealListViewConstants.imageHeight, height: MealListViewConstants.imageHeight)
            .aspectRatio(contentMode: .fill)
            .clipped()
            .cornerRadius(MealListViewConstants.imageCornerRadius)
            .overlay(RoundedRectangle(cornerRadius: MealListViewConstants.imageCornerRadius)
                .stroke(Color(.systemGray5), lineWidth: MealListViewConstants.imageStrokeLineWidth)
            )

            VStack(alignment: .leading, spacing: 5) {
                Text(meal.strMeal)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(category.strCategory)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, MealListViewConstants.vStackLeadingPadding)
            
            Spacer()
        }
        .padding(.vertical, MealListViewConstants.rowVerticalPadding)
        .padding(.horizontal, MealListViewConstants.rowHorizontalPadding)
        .background(Color(.systemBackground))
        .cornerRadius(MealListViewConstants.rowCornerRadius)
        .shadow(color: Color.black.opacity(MealListViewConstants.rowShadowOpacity), radius: MealListViewConstants.rowShadowRadius, x: 0, y: 2)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    MealRowView(meal: MealList(
        idMeal: "52772",
        strMeal: "Teriyaki Chicken Casserole",
        strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!
    ), category: Category(idMeal: "52772", strMeal: "Teriyaki Chicken Casserole", strCategory: "Chicken"))
}
