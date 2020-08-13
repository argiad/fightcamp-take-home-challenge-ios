//
//  MainViewController.swift
//  FightCamp-Homework
//
//  Created by Artem Mkrtchyan on 8/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    var packageView = PackageView()
    var tableView = UITableView()
    
    lazy var viewModel: ViewModel = {
           let model = ViewModel.instance
           return model
       }()

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .secondaryBackground

        bindView()
    }
    
    func preparePView() {
        packageView.isStandAlone = true
        packageView.cornerRadius = .packageRadius
        packageView.backgroundColor = .primaryBackground
        self.view.addSubview(packageView)
    }
    
    func preapareList() {
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableViewC1 = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: .packageSpacing)
        let tableViewC2 = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: .packageSpacing * -1)
        let tableViewC3 = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: .packageSpacing)
        let tableViewC4 = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: .packageSpacing * -1)
        
        self.view.addConstraints([tableViewC1, tableViewC2, tableViewC3, tableViewC4])
        
//        tableView.backgroundView = nil
        tableView.backgroundColor = .secondaryBackground
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func bindView() {
        
        viewModel.$packageToShow.sink{ [weak self] v in
            print(">>>> \(v)")
            guard let self = self else { return }
            
            self.view.subviews.forEach{$0.removeFromSuperview()}
            self.view.removeConstraints(self.view.constraints)
            
            if v < 0 {
                self.preapareList()
                return
            }
            self.preparePView()
            self.packageView.setup(with: self.viewModel.packages[v])
            self.packageView.package = nil
            
        }.store(in: &cancellables)
        
                
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.packages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MyCell(style: .default, reuseIdentifier: nil)
        
        cell.index = indexPath.row
        
        return cell
        
    }
    
    
}

class MyCell: UITableViewCell {
    
    var index: Int? = nil
    var pv: PackageView? = nil
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        contentView.backgroundColor = .secondaryBackground
        
        if (pv == nil) {
            pv = PackageView()
            pv!.cornerRadius = .packageRadius
            pv!.backgroundColor = .primaryBackground
            contentView.addSubview(pv!)
//            let viewConstraint = NSLayoutConstraint(item: pv!, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
//            contentView.addConstraint(viewConstraint)

            pv!.setup(with: ViewModel.instance.packages[index!])
        }
    }
    
}
