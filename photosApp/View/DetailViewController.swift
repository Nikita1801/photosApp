//
//  DetailViewController.swift
//  photosApp
//
//  Created by Никита Макаревич on 09.10.2022.
//

import UIKit
import Nuke

protocol DetailsViewControllerDelegate: UIViewController {
    func didTapPhoto(photo: Photos)
}


final class DetailViewController: UIViewController {
    
    weak var photosDelegate: PhotosViewControllerDelegate?
//    weak var favoriteDelegate: FavoriteViewControllerDelegate?
    private var photoInfo: Photos?
    private var isTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return imageView
    }()
    
    private let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Lisabon"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 11, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "564 likes"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 11, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.contentMode = .scaleToFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
}

private extension DetailViewController {
    
    @objc func didTapFavoriteButton() {

        guard let photoInfo = photoInfo else { return }
        if isTapped{
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isTapped = false
            photosDelegate?.deleteFromFavorite(photo: photoInfo)
        }
        else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isTapped = true
            photosDelegate?.addToFavorite(photo: photoInfo)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(photoImageView)
        locationStackView.addSubview(locationLabel)
        locationStackView.addSubview(likesLabel)
        view.addSubview(locationStackView)
        nameStackView.addSubview(nameLabel)
        nameStackView.addSubview(dateLabel)
        view.addSubview(nameStackView)
        view.addSubview(favoriteButton)

        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height/1.8),
            
            locationStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
            locationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: locationStackView.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationStackView.leadingAnchor, constant: 16),
            
            likesLabel.topAnchor.constraint(equalTo: locationStackView.topAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: locationStackView.trailingAnchor, constant: -16),

            nameStackView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 20),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: nameStackView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -30),
            
            favoriteButton.topAnchor.constraint(equalTo: nameStackView.topAnchor, constant: 5),
            favoriteButton.trailingAnchor.constraint(equalTo: nameStackView.trailingAnchor, constant:  -16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 22),
            favoriteButton.widthAnchor.constraint(equalToConstant: 26),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
}

extension DetailViewController: DetailsViewControllerDelegate {
    func didTapPhoto(photo: Photos) {
        photoInfo = photo
        nameLabel.text = "\(photo.user.username) (\(photo.user.name))"
        dateLabel.text = photo.created_at
        locationLabel.text = photo.user.location
        likesLabel.text = String("\(photo.likes) likes")
        
        let url = photo.urls.regular
        Nuke.loadImage(with: url, into: photoImageView)
    }
}
