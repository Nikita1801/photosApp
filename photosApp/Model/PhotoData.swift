//
//  PhotoData.swift
//  photosApp
//
//  Created by Никита Макаревич on 06.10.2022.
//

import Foundation

struct PhotoData: Codable {
    let results: [Photos]
}

struct Photos: Codable, Equatable {
    let urls: URLs
    let user: User
    let created_at: String
    let likes: Int
    let width: Int
    let height: Int
}

struct URLs: Codable, Equatable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct User: Codable, Equatable {
    let username: String
    let name: String
    let location: String?
    
}
