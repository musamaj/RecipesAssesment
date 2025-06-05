//
//  RecipeService.swift
//  Recipes
//
//  Created by Usama Jamil on 6/4/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case emptyData
}

protocol RecipeServiceProtocol {
    func fetchRecipes(from urlString: String) async throws -> [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    func fetchRecipes(from urlString: String) async throws -> [Recipe] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        if data.isEmpty {
            throw NetworkError.emptyData
        }

        do {
            let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return decoded.recipes
        } catch {
            throw NetworkError.decodingError
        }
    }
}
