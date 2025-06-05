//
//  RecipeRowView.swift
//  Recipes
//
//  Created by Usama Jamil on 6/4/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    @State private var image: UIImage?

    var body: some View {
        HStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                    .overlay(
                        ProgressView()
                    )
            }

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .task {
            if let url = recipe.photoURLSmall {
                image = await ImageCache.shared.image(for: url)
            }
        }
    }
}
