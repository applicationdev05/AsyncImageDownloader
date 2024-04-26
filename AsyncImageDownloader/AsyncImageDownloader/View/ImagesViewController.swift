//
//  ImagesViewController.swift
//  AsyncImageDownloader
//
//  Created by Rajat Pandya on 26/04/24.
//

import UIKit

final class ImagesViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel: ImagesViewModel!
    let cacheManager: CacheManager = CacheManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = ImagesViewModel(manager: NetworkManager())
        setupCollectionView()
        title = "Images"
        fetchImages()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.size.width - 2) / 3 // Subtract 2 for interitem spacing
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func fetchImages() {
        viewModel.fetchImages(page: viewModel.currentPage, completion: { [weak self] images, error  in
            
            guard let self = self else { return }
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            
            self.viewModel.images.append(contentsOf: images)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }

}

// MARK: EXT: -

extension ImagesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
            fatalError("Failed to dequeue ImageCell")
        }
        
        let imageUrl = viewModel.images[indexPath.item].download_url
        cell.configure(with: imageUrl, cacheManager: cacheManager)
        return cell
    }
    
}

// UICollectionViewDelegateFlowLayout method for determining when to fetch more data

extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.images.count - 10 {
            fetchImages()
            viewModel.currentPage += 1
        }
    }
}
