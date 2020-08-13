//
//  TypePriceView.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class TypePriceView : UIStackView {

    private lazy var paymentType: UILabel! = {
        let lbl = UILabel()
        lbl.text = "Paymanet type"
        lbl.font = .body
        lbl.textColor = .label
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var priceAmount: UILabel! = {
        let lbl = UILabel()
        lbl.text = "PRICE"
        lbl.font = .price
        lbl.textColor = .label
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    func setup(with package: Package) {
        
        paymentType.text = package.payment
        priceAmount.text = "$ \(Float(package.price) / 10)"
        
        paymentType.sizeToFit()
        priceAmount.sizeToFit()
        
        addArrangedSubview(paymentType)
        addArrangedSubview(priceAmount)
        
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        autoresizesSubviews = true
        axis = .vertical
        distribution = .fill
        spacing = .thumbnailSpacing
        
    }
    

}

