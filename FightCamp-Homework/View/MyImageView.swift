//
//  UIImageView+Extension.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class MyImageView: UIImageView {
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.image = nil

        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = MyImageView.imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self?.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let self = self, let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            MyImageView.self.imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
