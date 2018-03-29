//
//  ImageStore.swift
//  Homepwner
//
//  Created by Alpaca on 2017. 7. 28..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
        
        // 이미지의 전체 URL을 만든다.
        let imageURL = imageURLForKey(key: key)
        
        // 이미지를 JPEG 데이터로 만든다.
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            // 이 데이터를 전체 URL에 쓴다
            do {
                try data.write(to: imageURL)
            } catch {
                print("Error")
            }
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as AnyObject) as? UIImage {
            return existingImage
        }
        
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as AnyObject)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as AnyObject)
        
        let imageURL = imageURLForKey(key: key)
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
    
    func imageURLForKey(key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = documentDirectories.first else {
            return URL(fileURLWithPath: "")
        }
        return documentDirectory.appendingPathComponent(key)
    }
}
