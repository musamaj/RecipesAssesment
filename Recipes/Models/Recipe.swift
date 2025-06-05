//
//  Recipe.swift
//  Recipes
//
//  Created by Usama Jamil on 6/4/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    let cuisine: String
    let name: String
    let photoURLLarge: URL?
    let photoURLSmall: URL?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
