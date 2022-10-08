//
//  PhotosCollectionViewCell.swift
//  photosApp
//
//  Created by Никита Макаревич on 07.10.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return imageView
    }()
    
    func set(photo: Photos) {
        let url = photo.urls["regular"]
        print("URL OF THIS PHOTO IS: \(url)")
    }
}

private extension PhotosCollectionViewCell {
    func configureView() {
        addSubview(photoImageView)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
