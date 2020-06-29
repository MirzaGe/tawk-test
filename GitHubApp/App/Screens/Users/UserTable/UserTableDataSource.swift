//
//  UserTableDataSource.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol UserTableDataSourceEvents {
    var loadMore: ControlEvent<Void> { get }
    var cellClicked: ControlEvent<UserFormatter> { get }
}

final class UserTableDataSource: NSObject, UserTableDataSourceEvents {
    
    typealias Data = UserCellViewModel
    
    var data: BehaviorRelay<[Data]> = BehaviorRelay(value: [])
    var shouldLoadMore: Bool = true
    
    private weak var tableView: UITableView?
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
    
        data.asDriver()
            .drive(onNext: { [unowned self] (data) in
                self.tableView?.reloadData()
            })
            .disposed(by: self.disposeBag)
        
    }

    private let _loadMore: PublishRelay<Void> = PublishRelay()
    var loadMore: ControlEvent<Void> {
        return ControlEvent(events: _loadMore)
    }
    
    private let _cellClicked: PublishRelay<UserFormatter> = PublishRelay()
    var cellClicked: ControlEvent<UserFormatter> {
        return ControlEvent(events: _cellClicked)
    }
    
    let disposeBag = DisposeBag()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension UserTableDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.data.value[indexPath.row]
        
        guard let cell = model.dequeueCell(tableView: tableView, indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configureWith(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == (self.data.value.count - 1)
            && shouldLoadMore {
            
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = spinner
            
            self._loadMore.accept(())
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let data = self.data.value[indexPath.row] as? UserFormatter {
            self._cellClicked.accept(data)
        }
        
    }
    
}
