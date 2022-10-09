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

protocol PhotosViewControllerDelegate: AnyObject {
    func addToFavorite(photo: Photos)
    func deleteFromFavorite(photo: Photos)
}




final class PhotosViewController: UIViewController {
    

    private lazy var detailViewController: DetailsViewControllerDelegate = {
        let detail = DetailViewController()
        detail.photosDelegate = self
        return detail
    }()

    private var presenter: PhotosPresenterProtocol?
    private var timer: Timer?
    private var photosArray: [Photos] = []
    private let collectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
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
        collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
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
        view.backgroundColor = .white
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
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
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

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        let photo = photosArray[indexPath.row]
        cell.set(photo: photo)
        
//        cell.backgroundColor = .lightGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photosArray[indexPath.row]
        detailViewController.didTapPhoto(photo: photo)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photosArray[indexPath.row]
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

extension PhotosViewController: PhotosViewControllerDelegate {

    func addToFavorite(photo: Photos) {
        print("Add to favorite")
        
    }
    
    func deleteFromFavorite(photo: Photos) {
        print("Delete from favorite")
    }
}
