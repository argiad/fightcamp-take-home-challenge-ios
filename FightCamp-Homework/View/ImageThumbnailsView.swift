//
//  ImageThumbnailsView.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit


class ImageThumbnailsView: UIStackView {
    
    private lazy var previewImage: MyImageView! = {
        let image = MyImageView()
        image.backgroundColor = .systemGray
        image.cornerRadius = .thumbnailRadius
        return image
    }()
    
    private lazy var thumbImages: [MyImageView]! = {
        
        let subviews = (0..<4).map { (_) -> MyImageView in
            let iv = MyImageView()
            iv.contentMode = .scaleToFill
            iv.aspectRatio(1.0/1.0)
            iv.cornerRadius = .thumbnailRadius
            iv.backgroundColor = .systemGray
            return iv
        }
        return subviews
    }()
    
    func setup(with package: Package) {
        translatesAutoresizingMaskIntoConstraints = false
        
        previewImage.imageFromServerURL(package.thumbnail_urls[package.selectedImage ?? 0 ], placeHolder: nil)
        NSLayoutConstraint.activate([
            previewImage.heightAnchor.constraint(equalToConstant: .thumbnailHeight)
        ])
        addArrangedSubview(previewImage)
        
        let thumbs = UIStackView()
        
        thumbImages.enumerated().forEach{ index , item in
            thumbs.addArrangedSubview(item)
            item.imageFromServerURL(package.thumbnail_urls[index], placeHolder: nil)
            item.borderWidth = .thumbnailBorderWidth
            item.borderColor = .thumbnailBorder(selected: false)
            
            let itemTap = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
            item.isUserInteractionEnabled = true
            item.addGestureRecognizer(itemTap)
        }
        
        thumbImages[0].borderColor = .thumbnailBorder(selected: true)
        
        thumbs.axis = .horizontal
        thumbs.distribution = .fill
        thumbs.spacing = .thumbnailSpacing
        addArrangedSubview(thumbs)
        
        autoresizesSubviews = true
        axis = .vertical
        distribution = .fill
        spacing = .thumbnailSpacing
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        if let item = sender.view as? MyImageView, let index = thumbImages.firstIndex(where: { $0 == item }) {
            thumbImages.enumerated().forEach{ $1.borderColor = .thumbnailBorder(selected: $0 == index)}
            previewImage.image = item.image
            
        }
        
    }
}
