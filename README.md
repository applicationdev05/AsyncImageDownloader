# AsyncImageDownloader

This is a Swift project for asynchronously downloading images with pagination. The project is structured with several classes and files to manage network requests, caching, and UI display.

Classes and Files:
NetworkManager.swift:
This class handles network requests for downloading image data asynchronously. It includes functions to fetch images from remote URLs.
CacheManager.swift:
CacheManager is responsible for caching image data locally to optimize performance and reduce redundant network requests.
APIEndPoints.swift:
APIEndPoints contains constants or enums that define the endpoints used for fetching images from the server.
ImageData.swift:
This file contains the model structure for image data, including properties like image URL, size, etc.
ImagesViewController.swift:
ImagesViewController is the view controller responsible for displaying images in a collection view. It interacts with ImagesViewModel to fetch and display images.
ImageCell.xib and ImageCell.swift:
ImageCell.xib is a nib file representing the UI layout for each cell in the collection view.
ImageCell.swift is the corresponding class file for ImageCell.xib. It manages the UI elements inside the cell and populates them with image data.
ImagesViewModel.swift:
ImagesViewModel acts as the intermediary between the ImagesViewController and the NetworkManager. It handles business logic related to fetching and managing image data.
Usage:
Import the required files into your Swift project.
Initialize an instance of ImagesViewController and set it up to display images.
ImagesViewController will interact with ImagesViewModel, which in turn communicates with NetworkManager to fetch image data asynchronously.
Pagination logic can be implemented within ImagesViewModel to load more images as the user scrolls through the collection view.
Requirements:
Swift 5 or later
iOS 11.0 or later (if targeting iOS)
Xcode 11 or later
Installation:
Simply add the provided files to your Xcode project.

License:
This project is licensed under the MIT License.

Author:
Rajat Pandya \\ 9589163226s
