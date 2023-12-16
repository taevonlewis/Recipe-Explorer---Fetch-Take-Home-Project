//
//  MealDetailView.swift
//  Recipe App
//
//  Copyright © 2023 TaeVon Lewis. All rights reserved.
//


import SwiftUI

struct MealDetailView: View {
    @State var viewModel = MealDetailViewModel()
    let mealID: String
    let mealImageURL: URL

    init(mealID: String, mealImageURL: URL) {
        self.mealID = mealID
        self.mealImageURL = mealImageURL
        viewModel.fetchMealDetail(mealID: mealID)
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: MealDetailViewConstants.sectionSpacing) {
                if let mealDetail = viewModel.mealDetail {
                    Text(mealDetail.strMeal)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                        .padding(.leading)

                    AsyncImage(url: mealImageURL) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(MealDetailViewConstants.placeholderOpacity)
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(height: MealDetailViewConstants.imageHeight)
                    .clipped()

                    Group {
                        Text("Instructions")
                            .font(.headline)
                            .padding(.top)

                        Text(mealDetail.strInstructions)
                            .foregroundColor(.secondary)
                            .padding(.bottom)

                        Text("Ingredients")
                            .font(.headline)
                            .padding(.top)

                        ForEach(mealDetail.ingredients.keys.sorted(), id: \.self) { key in
                            if let value = mealDetail.ingredients[key], !value!.isEmpty {
                                HStack {
                                    Text(key.capitalized)
                                        .bold()
                                    Spacer()
                                    Text(value!)
                                }
                                .padding(.vertical, MealDetailViewConstants.verticalPadding)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitle("Meal Details", displayMode: .inline)
    }
}

struct MealDetailViewConstants {
        static let imageHeight: CGFloat = 300
        static let sectionSpacing: CGFloat = 10
        static let verticalPadding: CGFloat = 2
        static let placeholderOpacity: Double = 0.3
    
}

#Preview {
    guard let imageURL = URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg") else {
        fatalError("nope")
    }

    return MealDetailView(mealID: "52772", mealImageURL: imageURL)
}
