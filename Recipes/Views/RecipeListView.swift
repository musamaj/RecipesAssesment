//
//  ContentView.swift
//  Recipes
//
//  Created by Usama Jamil on 6/4/25.
//

import SwiftUI

struct RecipeListView<ViewModel: RecipeListViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    @State private var hasLoaded = false  // prevents multiple calls
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.recipes.isEmpty {
                    ProgressView("Loading Recipes...")
                } else if let message = viewModel.errorMessage {
                    Text(message)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.recipes.isEmpty {
                    Text("No recipes available.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.recipes) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.loadRecipes(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                Button("Refresh") {
                    Task {
                        await viewModel.loadRecipes(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
                    }
                }
            }
            .task {
                await viewModel.loadRecipes(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
                
                // For testing malformed data
                //await viewModel.loadRecipes(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
                
                // For empty Data
//                if !hasLoaded {
//                    hasLoaded = true
//                        await viewModel.loadRecipes(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
//                }
            }
        }
    }
}
