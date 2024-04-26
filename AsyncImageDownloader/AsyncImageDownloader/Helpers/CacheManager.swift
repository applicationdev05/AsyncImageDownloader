//
//  CacheManager.swift
//  AsyncImageDownloader
//
//  Created by Rajat Pandya on 26/04/24.
//

import Foundation
import UIKit

final class CacheManager {
    
    private let imageCache = NSCache<AnyObject, UIImage>()
    private let cacheQueue = DispatchQueue(label: "com.app.cacheQueue", attributes: .concurrent)
    
    init() {
        imageCache.countLimit = 1000
    }
    
    func saveImageToCache(image: UIImage, forKey key: String) {
        cacheQueue.async(flags: .barrier) {
            self.imageCache.setObject(image, forKey: key as NSString)
        }
    }
    
    func loadImageFromCache(forKey key: String, completion: @escaping (UIImage?, Bool) -> Void) {
        cacheQueue.async {
            if let cachedImage = self.imageCache.object(forKey: key as NSString) {
                // Image exists in cache
                completion(cachedImage, true)
            } else {
                // Image does not exist in cache
                completion(nil, false)
            }
        }
    }
    
}
