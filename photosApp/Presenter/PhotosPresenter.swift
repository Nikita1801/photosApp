//
//  PhotosPresenter.swift
//  photosApp
//
//  Created by Никита Макаревич on 06.10.2022.
//

import UIKit

protocol PhotosPresenterProtocol {
    func getPhotos()
    func getPhotosByKeyword(query: String)
}

final class PhotosPresenter {
    private weak var viewController: PhotosViewControllerProtocol?
    private var model: PhotosModelProtocol
    
    init(viewController: PhotosViewControllerProtocol?,
         model: PhotosModelProtocol = PhotosModel()) {
        self.viewController = viewController
        self.model = model
    }
}

extension PhotosPresenter: PhotosPresenterProtocol {
    func getPhotosByKeyword(query: String) {
        model.getPhotosByKeyword(query: query) { photos in
            DispatchQueue.main.async {
                self.viewController?.updatePhotos(photos.results)
            }
        }
    }
    
    func getPhotos() {
        model.getPhotos { [weak viewController] photos in
            DispatchQueue.main.async {
                viewController?.updatePhotos(photos)
            }
        }
    }
}
