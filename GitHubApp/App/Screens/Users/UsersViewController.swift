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
    
    private var usersShimmerView: UsersShimmerView?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.usersShimmerView?.startShimmer()
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
        
        // shimmer
        let shimmerView = UsersShimmerView()
        shimmerView.backgroundColor = AppColors.backgroundColor.value
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.usersShimmerView = shimmerView
        
        self.view.addSubview(self.usersShimmerView!)
        
        NSLayoutConstraint.activate([
            self.usersShimmerView!.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 190),
            self.usersShimmerView!.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor),
            self.usersShimmerView!.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor),
            self.usersShimmerView!.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor)
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
            .asObservable()
            .filter({ $0 == false })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (data) in
                if !data {
                    self.tableView.tableFooterView = nil
                    self.usersShimmerView?.removeFromSuperview()
                    self.usersShimmerView = nil
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
