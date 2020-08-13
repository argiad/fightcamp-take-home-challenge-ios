//
//  FeaturesTableView.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class FeaturesTableView: UITableView {
    
    private var included: [String] = []
    private var excluded: [String] = []
    
    func setup(with package: Package) {
        
        separatorStyle = .none
        
        delegate = self
        dataSource = self
        
        included = package.included
        excluded = package.excluded ?? []
        
        reloadData()
        
    }
    
    private struct Feature {
        var type: Int
        var text: String
    }
}


extension FeaturesTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIFont.body.lineHeight + 2
    }
}

extension FeaturesTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (included.isEmpty ? 0 : 1) + (excluded.isEmpty ? 0 : 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? included.count : excluded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = .body
        if (indexPath.section == 0) {
            cell.textLabel?.text = included[indexPath.row]
            cell.textLabel?.textColor = .label
        } else {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: excluded[indexPath.row])
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            cell.textLabel?.attributedText = attributeString
            cell.textLabel?.textColor = .disabledLabel
        }
        return cell
    }
    
    
}
