//
//  Package.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

struct Package: Codable, Equatable {
    
    let title: String
    let desc: String
    
    let thumbnail_urls: [String]
    let included: [String]
    let excluded: [String]?
    
    let payment: String
    let price: Int
    let action: String
    
    var selectedImage: Int? = 0
}
