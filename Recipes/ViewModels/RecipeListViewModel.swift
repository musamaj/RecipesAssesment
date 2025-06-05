//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Usama Jamil on 6/4/25.
//

import Foundation

protocol RecipeListViewModelProtocol: ObservableObject {
    var recipes: [Recipe] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadRecipes(url: String) async
}

class RecipeListViewModel: RecipeListViewModelProtocol {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service: RecipeServiceProtocol
    
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }
    
    @MainActor
    func loadRecipes(url: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let recipes = try await service.fetchRecipes(from: url)
            self.recipes = recipes
        } catch {
            self.recipes = []
            switch error {
            case NetworkError.emptyData:
                errorMessage = nil  // Show empty state
            case NetworkError.decodingError:
                errorMessage = "Malformed data. Could not load recipes."
            default:
                errorMessage = "Something went wrong. Please try again."
            }
        }
        isLoading = false
    }

}
