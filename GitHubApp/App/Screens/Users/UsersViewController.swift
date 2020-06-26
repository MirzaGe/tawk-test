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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
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
        
        configureSearchBar()
        configureTableView()
        
    }
    
    private func configureSearchBar() {
        
        self.searchBar.searchResultsUpdater = self
    
    }
    
    private func configureTableView() {
        
        tableView.register(cellType: UserTableViewCell.self)
        
        userDatasource = UserTableDataSource(tableView)
        
        tableView.dataSource = userDatasource
        tableView.delegate = userDatasource
        
        userDatasource?.loadMore
            .asDriver()
            .drive(onNext: { [unowned self] in
                self.viewModel?.loadMoreUsers()
            })
            .disposed(by: self.disposeBag)
        
        tableView.refreshControl = self.refreshControl
        
        self.refreshControl.rx.controlEvent(.valueChanged)
            .map { [unowned self] _ in
                self.refreshControl.isRefreshing == false
            }
            .filter { $0 == false }
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.getUsers()
            })
            .disposed(by: self.disposeBag)
        
        self.refreshControl.rx.controlEvent(.valueChanged)
            .map { _ in
                self.refreshControl.isRefreshing == true
            }
            .filter { $0 == true }
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.refreshControl.endRefreshing()
            })
            .disposed(by: self.disposeBag)
        
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
        
        self.viewModel?
        .outputs()
            .isLoadingMoreUsers
            .asDriver()
            .filter({ $0 == false })
            .drive(onNext: { [unowned self] (data) in
                if !data {
                    self.tableView.tableFooterView = nil
                }
            })
            .disposed(by: self.disposeBag)
        
    }

}

extension UsersViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        
        self.viewModel?.searchUser(key: searchController.searchBar.text!)
        
    }

}
