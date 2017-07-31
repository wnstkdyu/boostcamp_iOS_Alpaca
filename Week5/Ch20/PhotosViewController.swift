//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Alpaca on 2017. 7. 30..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore = PhotoStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos(completion: {
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) recent photos.")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImageForPhoto(
                        photo: firstPhoto,
                        completion: {
                            (ImageResult) -> Void in
                            
                            switch ImageResult {
                            case let .success(image):
                                OperationQueue.main.addOperation({
                                    self.imageView.image = image
                                })
                            case let .failure(error):
                                print("Error downloading image: \(error)")
                            }
                        }
                    )
                }
            case let .failure(error):
                print("Error fetching recent photos: \(error)")
            }
        })
    }
}
