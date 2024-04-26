//
//  APIEndPoints.swift
//  AsyncImageDownloader
//
//  Created by Rajat Pandya on 26/04/24.
//

import Foundation

struct APIEndpoints {
    
    static func imagesURL(page: Int, limit: Int) -> URL? {
        let urlString = "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)"
        return URL(string: urlString)
    }

}
