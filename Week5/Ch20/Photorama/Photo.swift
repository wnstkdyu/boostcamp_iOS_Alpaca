//
//  Photo.swift
//  Photorama
//
//  Created by Alpaca on 2017. 7. 31..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class Photo {
    
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    var image: UIImage?
    
    init(title: String, remoteURL: URL, photoID: String, dateTaken: Date) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
    }
}

extension Photo: Equatable { }

func == (lhs: Photo, rhs: Photo) -> Bool {
    // 같은 photoID를 가지면 두 사진은 같다.
    return lhs.photoID == rhs.photoID
}
