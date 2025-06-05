//
//  ImageCache.swift
//  Recipes
//
//  Created by Usama Jamil on 6/4/25.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    
    private init() {}

    private let cacheDirectory: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }()

    func image(for url: URL) async -> UIImage? {
        let filename = cacheDirectory.appendingPathComponent(url.lastPathComponent)

        if let data = try? Data(contentsOf: filename), let image = UIImage(data: data) {
            return image
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try data.write(to: filename)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
