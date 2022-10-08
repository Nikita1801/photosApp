//
//  PhotosViewController.swift
//  photosApp
//
//  Created by Никита Макаревич on 06.10.2022.
//

import UIKit

protocol PhotosViewControllerProtocol: AnyObject {
    func updatePhotos(_ photos: PhotoData)
}

final class PhotosViewController: UIViewController {
    
    private var presenter: PhotosPresenterProtocol?
    private var timer: Timer?
    private var photosArray: [Photos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PhotosPresenter(viewController: self)
        getPhotos()
        
        configureView()
        
        
    }
    
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.lightGray
        
        return collectionView
    }()
    
    private let searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search on Unsplash"
        label.textColor = .gray
        
        return label
    }()
    
}

extension PhotosViewController: PhotosViewControllerProtocol {
    func updatePhotos(_ photos: PhotoData) {
        photosArray = photos.results
        photosCollectionView.reloadData()
        print(photos.results)
    }
    
}

private extension PhotosViewController {
    
    func getPhotos() {
        presenter?.getPhotos()
    }
    
    func configureSerachBar() {
        let searchBar = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchBar
        searchBar.searchBar.delegate = self
    }
    
    func configureView() {
        view.backgroundColor = .blue
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        configureSerachBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: searchTitle)
        
        view.addSubview(photosCollectionView)
        
        setConstaints()
    }
    
    func setConstaints() {
        
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}
extension PhotosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)

//        timer = Timer(timeInterval: 0.5, repeats: true, block: { (timer) in
            self.presenter?.getPhotosByKeyword(query: searchText)
//            print("after 1 sec")
//        })
        print("0")
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        let photo = photosArray[indexPath.row]
        cell.set(photo: photo)
        
        cell.backgroundColor = .red
        
        return cell
    }
    
    
}
