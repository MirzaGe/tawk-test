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

protocol UsersViewControllerRoute {
    func routeToUserDetail(_ vc: UsersViewController, data: UserFormatter)
}

class UsersViewController: BaseViewController {

    // MARK: - Properties
    var viewModel: UsersViewModelInputs?
    var coordinator: UsersViewControllerRoute?
    
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
    var hasAppear: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !hasAppear {
            self.usersShimmerView?.startShimmer()
            self.viewModel?.getUsers()
            hasAppear.toggle()
        } else {
            self.viewModel?.getUsers()
        }
        
    }
    
    private func setupObserver() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(backOnline),
                                               name: AppNotificationName.onlineMode,
                                               object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func backOnline() { // to reload again once back online
        self.viewModel?.getUsers()
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
        
        tableView.register(cellType: UserNormalTableViewCell.self)
        tableView.register(cellType: UserInvertedTableViewCell.self)
        tableView.register(cellType: UserNoteTableViewCell.self)
        tableView.register(cellType: UserNoteInvertedTableViewCell.self)
        
        userDatasource = UserTableDataSource(tableView)
        
        tableView.dataSource = userDatasource
        tableView.delegate = userDatasource
        
        // data source events
        userDatasource?.loadMore
            .asDriver()
            .drive(onNext: { [unowned self] in
                self.viewModel?.loadMoreUsers()
            })
            .disposed(by: self.disposeBag)
        
        userDatasource?.cellClicked
            .asDriver()
            .drive(onNext: { [unowned self] (data) in
                self.coordinator?.routeToUserDetail(self, data: data)
            })
            .disposed(by: self.disposeBag)
        
        // refresh control events
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
                    self.refreshControl.endRefreshing()
                    self.tableView.tableFooterView = nil
                    self.usersShimmerView?.removeFromSuperview()
                }
            })
            .disposed(by: self.disposeBag)
        
        viewModel?.outputs()
            .error
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (message) in
                self.alert(title: AppStrings.errorTitle.rawValue.getLocalize(),
                           okayButtonTitle: AppStrings.okTitle.rawValue.getLocalize(),
                           withBlock: nil)
            })
            .disposed(by: self.disposeBag)
        
        viewModel?.outputs()
            .shouldShowLoadMore
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (data) in
                self.userDatasource?.shouldLoadMore = data
            })
            .disposed(by: self.disposeBag)
        
    }

    private func getUsers() {
        
    }
    
}

extension UsersViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        
        self.viewModel?.searchUser(key: searchController.searchBar.text!)
        
    }

}
