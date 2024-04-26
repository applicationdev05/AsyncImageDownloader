//
//  ImageCell.swift
//  AsyncImageDownloader
//
//  Created by Rajat Pandya on 26/04/24.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    var imageUrl: String?
    static let identifier: String = "ImageCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil // Reset the image view when cell is reused
        imageUrl = nil
    }
    
    func configure(with imageUrl: String, cacheManager: CacheManager) {
        self.imageUrl = imageUrl
        
        cacheManager.loadImageFromCache(forKey: imageUrl) { [weak self] cachedImage, existsInCache in
            guard let self = self else { return }
            
            if let image = cachedImage {
                self.updateImageView(with: image)
            } else {
                self.downloadImage(with: imageUrl, cacheManager: cacheManager)
            }
        }
    }

    private func updateImageView(with image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    private func downloadImage(with imageUrl: String, cacheManager: CacheManager) {
        guard let url = URL(string: imageUrl) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                cacheManager.saveImageToCache(image: image, forKey: imageUrl)
                self?.updateImageView(with: image)
            }
        }
    }

}
