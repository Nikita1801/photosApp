//
//  PhotosModel.swift
//  photosApp
//
//  Created by Никита Макаревич on 06.10.2022.
//

import Foundation

protocol PhotosModelProtocol {
    func getPhotos(completed: @escaping (PhotoData) -> Void)
    func getPhotosByKeyword(query: String, completed: @escaping (PhotoData) -> Void)
}

final class PhotosModel {
    private var network: PhotoServiceProtocol
    
    init(network: PhotoServiceProtocol = PhotoService()) {
        self.network = network
    }
}

extension PhotosModel: PhotosModelProtocol {
    func getPhotosByKeyword(query: String, completed: @escaping (PhotoData) -> Void) {
        let url = "https://api.unsplash.com/search/photos?page=1&query=\(query)&per_page=30&client_id=-1xc7qe0LH0jZbvV8T5mpzhS4RWyC8EpsNnSBkIQAKg"
        network.getPhotos(url: url) { photo in
            guard let photo = photo else { return }
            
            completed(photo)
            
        }
    }
    
    
    func getPhotos(completed: @escaping (PhotoData) -> Void) {
        let dispatchGroup = DispatchGroup()
        var photos: PhotoData?
        dispatchGroup.enter()
        let url = " " // ENTER URL
        network.getPhotos(url: url) { photo in
            if let photo = photo {
//                  photos.append(photo)
              }
              dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let photos = photos else { return }
            completed(photos)
        }
    }
    
}
