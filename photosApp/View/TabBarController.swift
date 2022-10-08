//
//  TabBarController.swift
//  photosApp
//
//  Created by Никита Макаревич on 06.10.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        setupTabBar()
    }
    
    private func setupTabBar(){
        
        
        guard let photoImage = UIImage(systemName: "photo.on.rectangle") else { return }
        guard let favoriteImage = UIImage(systemName: "heart") else { return }
        
        viewControllers = [
            createNavigationController(vc: PhotosViewController(), itemName: "Photos", itemImage: photoImage),
            createNavigationController(vc: FavoriteViewController(), itemName: "Favorite", itemImage: favoriteImage)
        ]
        
    }
    
    private func createNavigationController(vc: UIViewController, itemName: String, itemImage: UIImage) -> UIViewController{
        
        let navigationViewController = UINavigationController(rootViewController: vc)
        navigationViewController.tabBarItem.title = itemName
        navigationViewController.tabBarItem.image = itemImage
        
        return navigationViewController
    }
}
