//
//  UsersViewController.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UsersViewController: UIViewController {

    // MARK: - Properties
    var viewModel: UsersViewModelInputs?
    private var userDatasource: UserTableDataSource?
    private let disposeBag = DisposeBag()
    
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
        bindViewModel()
        
    }
    
    override func loadView() {
        super.loadView()
        
        viewModel?.getUsers()
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
    
    private func bindViewModel() {
        
        self.viewModel?
            .outputs()
            .users
            .asDriver()
            .drive(onNext: { [unowned self] (data) in
                self.userDatasource?.data.accept(data)
            })
            .disposed(by: self.disposeBag)
        
    }

}
