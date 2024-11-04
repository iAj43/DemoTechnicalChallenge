//
//  ImageCache.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import UIKit

class ImageCache {
    private var cache = NSCache<NSString, UIImage>()

    func loadImage(from url: URL) async throws -> UIImage {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ImageCacheError", code: -1, userInfo: nil)
        }

        cache.setObject(image, forKey: url.absoluteString as NSString)
        return image
    }
}
