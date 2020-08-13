//
//  PackageView.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageView: UIView {
    
    var package: Package?
    var isStandAlone = false
    
    func setup(with package: Package) {
        
        removeConstraints(constraints)
        subviews.forEach{ $0.removeFromSuperview() }
        self.package = package
        
        // MARK: -Title Label
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = package.title
        titleLabel.font = .title
        titleLabel.textColor = .brandRed
        titleLabel.sizeToFit()
        
        addSubview(titleLabel)
        let titleLabelC1 = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: .packageSpacing)
        let titleLabelC2 = NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: .packageSpacing * -1)
        let titleLabelC3 = NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: .packageSpacing)
        addConstraints([titleLabelC1, titleLabelC2, titleLabelC3])
        
        // MARK: - Description Label
        let descLabel = UILabel()
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.text = package.desc
        descLabel.font = .body
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 2
        descLabel.textColor = .label
        descLabel.sizeToFit()
        
        addSubview(descLabel)
        let descLabelC1 = NSLayoutConstraint(item: descLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: .packageSpacing)
        let descLabelC2 = NSLayoutConstraint(item: descLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: .packageSpacing * -1)
        let descLabelC3 = NSLayoutConstraint(item: descLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: .packageSpacing)
        addConstraints([descLabelC1, descLabelC2, descLabelC3])
        
        
        // MARK: - ImageThumbnailsView
        let images = ImageThumbnailsView()
        
        addSubview(images)
        let imagesC1 = NSLayoutConstraint(item: images, attribute: .top, relatedBy: .equal, toItem: descLabel, attribute: .bottom, multiplier: 1, constant: .packageSpacing)
        let imagesC2 = NSLayoutConstraint(item: images, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: .packageSpacing * -1)
        let imagesC3 = NSLayoutConstraint(item: images, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: .packageSpacing)
        addConstraints([imagesC1, imagesC2, imagesC3])
        
        images.setup(with: package)
        
        
        // MARK: - Action Button
        let actionButton = UIButton()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitle( isStandAlone ? "Add to Cart" : package.action, for: .normal)
        actionButton.titleLabel?.font = .button
        actionButton.setTitleColor(.buttonTitle, for: .normal)
        actionButton.setBackgroundColor(color: .buttonBackground, forState: .normal)
        actionButton.cornerRadius = .buttonRadius
        
        addSubview(actionButton)
        let actionButtonC1 = NSLayoutConstraint(item: actionButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: .packageSpacing * -1)
        let actionButtonC2 = NSLayoutConstraint(item: actionButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: .packageSpacing * -1)
        let actionButtonC3 = NSLayoutConstraint(item: actionButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: .packageSpacing)
        let actionButtonC4 = NSLayoutConstraint(item: actionButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .buttonHeight)
        
        addConstraints([actionButtonC1, actionButtonC2, actionButtonC3, actionButtonC4])
        
        
        actionButton.addTarget(self, action: #selector(self.pressed(_ :) ), for: .touchUpInside)
        
        // MARK: - TypePriceView
        let price = TypePriceView()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.setup(with: package)
        
        addSubview(price)
        let priceC1 = NSLayoutConstraint(item: price, attribute: .bottom, relatedBy: .equal, toItem: actionButton, attribute: .top, multiplier: 1, constant: .packageSpacing * -1)
        let priceC2 = NSLayoutConstraint(item: price, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: .packageSpacing * -1)
        let priceC3 = NSLayoutConstraint(item: price, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: .packageSpacing)
        
        addConstraints([priceC1, priceC2, priceC3])
        
        // MARK: - FeaturesTableView
        let table = FeaturesTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.setup(with: package)
        
        addSubview(table)
        let tableC1 = NSLayoutConstraint(item: table, attribute: .bottom, relatedBy: .equal, toItem: price, attribute: .top, multiplier: 1, constant: .packageSpacing * -1)
        let tableC2 = NSLayoutConstraint(item: table, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: .packageSpacing * -1)
        let tableC3 = NSLayoutConstraint(item: table, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: .packageSpacing)
        let tableC4 = NSLayoutConstraint(item: table, attribute: .top, relatedBy: .equal, toItem: images, attribute: .bottom, multiplier: 1, constant: .buttonHeight)
        
        addConstraints([tableC1, tableC2, tableC3, tableC4])
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let _ = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let packageViewC1 = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1, constant: .packageSpacing * (isStandAlone ? 1 : 0))
        let packageViewC2 = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1, constant: .packageSpacing * (isStandAlone ? -1 : 0 ))
        let packageViewC3 = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: (.packageSpacing + 30.0) * (isStandAlone ? 1 : 0))
        let packageViewC4 = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: .packageSpacing * -1)
        
        superview?.superview?.addConstraints([packageViewC1, packageViewC2, packageViewC3, packageViewC4])
    }
    
    @objc func pressed(_ sender: UIButton!) {
        if let index = ViewModel.instance.packages.firstIndex(where: {$0 == package}) {
            ViewModel.instance.packageToShow = index
        } else {
            ViewModel.instance.packageToShow = -1
        }
    }
}
