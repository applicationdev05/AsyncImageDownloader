//
//  ImagesViewModel.swift
//  AsyncImageDownloader
//
//  Created by Rajat Pandya on 26/04/24.
//

import Foundation

final class ImagesViewModel {
    
    private let manager: NetworkManageryProtocol
    
    var images: [ImageData] = []
    var currentPage = 1
    
    init(manager: NetworkManageryProtocol) {
        self.manager = manager
    }
    
    func fetchImages(page: Int, completion: @escaping (_ images: [ImageData], _ error: Error?) -> ()) {
        guard let url = APIEndpoints.imagesURL(page: page, limit: 15) else { return }
        
        guard let modifiedUrl = modifyImageUrl(url: url, width: 50, height: 50) else { return }
        
        manager.get(url: modifiedUrl, resultType: [ImageData].self) { [weak self] images, error in
            guard let self = self else { return }
            
            if let error = error {
                completion([], error)
                return
            }
            
            if let images = images {
                completion(images, nil)
            }
        }
    }

    private func modifyImageUrl(url: URL, width: Int, height: Int) -> URL? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "w", value: "\(width)"),
            URLQueryItem(name: "h", value: "\(height)")
        ]
        return components?.url
    }
    
}
