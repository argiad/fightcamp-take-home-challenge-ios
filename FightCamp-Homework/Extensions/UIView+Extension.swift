//
//  UIView+Extension.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    func aspectRatio(_ ratio: CGFloat)  {
        let constraint1 = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        addConstraint(constraint1)
    }
}
