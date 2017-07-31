//
//  ObjectInfo.swift
//  ImageBoard
//
//  Created by Alpaca on 2017. 8. 1..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import Foundation

struct ArticleInfo: Codable {
    let _id: String?
    let created_at: Int?
    let thumb_image_url: String?
    let author_nickname: String?
    let author: String?
    let image_desc: String?
    let image_title: String?
    let __v: Int?
}

struct UserInfo: Codable {
    let _id: String?
    let nickname: String?
    let password: String?
    let email: String?
    let __v: String?
}
