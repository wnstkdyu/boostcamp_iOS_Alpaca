//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Alpaca on 2017. 7. 30..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore = PhotoStore()
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchRecentPhotos { (photosResult) -> Void in
            OperationQueue.main.addOperation{
                switch photosResult {
                case let .success(photos):
                    print("Successfully found \(photos.count) recent photos.")
                    self.photoDataSource.photos = photos
                case let .failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto" {
            guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let photo = photoDataSource.photos[selectedIndexPath.row]
            
            guard let destinationVC = segue.destination as? PhotoInfoViewController else { return }
            destinationVC.photo = photo
            destinationVC.store = store
        }
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        // 이미지 데이터를 내려받는다. 시간이 좀 걸릴 수 있다.
        store.fetchImageForPhoto(photo: photo){ (result) -> Void in
            OperationQueue.main.addOperation{
                // 사진의 인덱스 패스는 요청의 시작과 끝 사이에 변경될 수 있다.
                // 따라서 가장 최근 인덱스 패스를 찾는다.
                let photoIndex = self.photoDataSource.photos.index(of: photo)!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                
                // 요청이 완료될 때 화면에 보이는 셀만 업데이트한다.
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
                }
            }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        
        return CGSize(width: viewWidth, height: viewHeight)
    }
}
