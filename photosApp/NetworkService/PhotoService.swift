//
//  PhotoService.swift
//  photosApp
//
//  Created by Никита Макаревич on 06.10.2022.
//

import Foundation

protocol PhotoServiceProtocol {
    func getPhotosByKeyword(url: String, completionHandler: @escaping (PhotoData?) -> Void)
    func getPhotos(url: String, completionHandler: @escaping ([Photos]?) -> Void)
}

final class PhotoService: PhotoServiceProtocol {

    func getPhotosByKeyword(url: String, completionHandler: @escaping (PhotoData?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        
        getRequest(url: url) { data in
            guard let data = data,
                  let model = try? JSONDecoder().decode(PhotoData.self, from: data)
            else {
                print("Error while decoding")
                completionHandler(nil)
                return
            }
            
            completionHandler(model)
        }
    }
    
    func getPhotos(url: String, completionHandler: @escaping ([Photos]?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        
        getRequest(url: url) { data in
            guard let data = data,
                  let model = try? JSONDecoder().decode([Photos].self, from: data)
            else {
                print("Error while decoding")
                completionHandler(nil)
                return
            }
            
            completionHandler(model)
        }
    }
    
}

private extension PhotoService {
    
    func getRequest(url: URL, completion: @escaping (Data?)->Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil
            else{
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
}


