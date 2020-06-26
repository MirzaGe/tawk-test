//
//  UsersViewController.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    // MARK: - Properties
    private var userDatasource: UserTableDataSource?
    
    // MARK: - UI Properties
    private lazy var searchBar: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        
        // navigation
        self.title = AppStrings.usersScreenTitle.rawValue.getLocalize()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = self.searchBar
        
        // view
        self.view.backgroundColor = AppColors.backgroundColor.value
        
        // table
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        configureTableView()
        
    }
    
    private func configureTableView() {
        
        tableView.register(cellType: UserTableViewCell.self)
        
        userDatasource = UserTableDataSource(tableView)
        
        tableView.dataSource = userDatasource
        tableView.delegate = userDatasource
        
    }

}
