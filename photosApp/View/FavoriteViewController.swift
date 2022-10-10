//
//  FavoriteViewController.swift
//  photosApp
//
//  Created by Никита Макаревич on 06.10.2022.
//

import UIKit

//protocol FavoriteViewControllerDelegate: AnyObject {
//    /// Открытие экарна с детальной информацией о фотографии
//    func addToFavorite(photo: Photos)
//}

protocol FavoriteViewControllerDelegate: AnyObject {
    func getFavoritePhoto(photo: Photos)
}

final class FavoriteViewController: UIViewController {
    
//    private lazy var detailViewController: DetailsViewControllerDelegate = {
//        let detail = DetailViewController()
//        detail.favoriteDelegate = self
//        return detail
//    }()
    
    private let photosViewController = PhotosViewController()
    private let collectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private var favoritePhotos: [Photos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosViewController.favoriteDelegate = self
        
        configureView()
    }
    
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
        return collectionView
    }()
    
    
}

private extension FavoriteViewController {
    func configureView() {
        view.backgroundColor = .white
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        
        view.addSubview(photosCollectionView)
        
        setConstaints()
    }
    
    func setConstaints() {
        
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoritePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        let photo = favoritePhotos[indexPath.row]
        cell.set(photo: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = favoritePhotos[indexPath.row]
//        detailViewController.didTapPhoto(photo: photo)
//        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = favoritePhotos[indexPath.row]
        let width = view.frame.width / 2.3
        let height = CGFloat(photo.height) * width / CGFloat(photo.width)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionInsets.left
    }
}


extension FavoriteViewController: FavoriteViewControllerDelegate {
    func getFavoritePhoto(photo: Photos) {
        print("Get")
    }
    
    
    //extension FavoriteViewController: FavoriteViewControllerDelegate {
    //    func addToFavorite(photo: Photos) {
    //        print("Add to favorite")
    //    }
    //}
}
