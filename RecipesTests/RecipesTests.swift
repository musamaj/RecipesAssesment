//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Usama Jamil on 6/4/25.
//

import XCTest
@testable import Recipes

final class RecipesTests: XCTestCase {
    
    let service = RecipeService()

    func testFetchRecipesReturnsValidList() async throws {
        let recipes = try await service.fetchRecipes(from: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty")
    }

    func testMalformedDataThrowsError() async {
        do {
            _ = try await service.fetchRecipes(from: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
            XCTFail("Expected decoding error but got success")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
    
    func testFetchRecipesEmptyResponse() async {
        do {
            _ = try await service.fetchRecipes(
                from: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
            )
        } catch let error as NetworkError {
            XCTAssertEqual(error, .emptyData)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

}
