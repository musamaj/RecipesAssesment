//
//  RecipeListViewModelTests.swift
//  Recipes
//
//  Created by Usama Jamil on 6/4/25.
//

import XCTest
@testable import Recipes

final class RecipeListViewModelTests: XCTestCase {
    class MockRecipeService: RecipeServiceProtocol {
        var shouldThrow: NetworkError?
        var mockRecipes: [Recipe] = []

        func fetchRecipes(from urlString: String) async throws -> [Recipe] {
            if let error = shouldThrow { throw error }
            return mockRecipes
        }
    }

    func testLoadRecipes_success() async {
        let mockService = MockRecipeService()
        mockService.mockRecipes = [Recipe(id: UUID(), cuisine: "Continental", name: "Steak", photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"), photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"))]

        let viewModel = RecipeListViewModel(service: mockService)
        await viewModel.loadRecipes(url: "")

        XCTAssertFalse(viewModel.recipes.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadRecipes_failure() async {
        let mockService = MockRecipeService()
        mockService.shouldThrow = .decodingError

        let viewModel = RecipeListViewModel(service: mockService)
        await viewModel.loadRecipes(url: "")

        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Malformed data. Could not load recipes.")
    }
}

