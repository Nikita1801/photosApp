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

struct Photos: Codable {
    let urls: [Urls.RawValue: String]
    
    enum Urls: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
