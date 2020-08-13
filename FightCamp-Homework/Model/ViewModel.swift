//
//  ViewModel.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
   
    public static var instance : ViewModel = {
        var instance = ViewModel()
        return instance
    } ()
    
    private init(){}
    
    @Published var packages: [Package] = {
        let decoder = JSONDecoder()
        
        if let url = Bundle.main.url(forResource: "packages", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let packages = try? decoder.decode([Package].self, from: data){
            return packages
        }
        return []
    }()
    
    @Published var packageToShow = -1
    
}
