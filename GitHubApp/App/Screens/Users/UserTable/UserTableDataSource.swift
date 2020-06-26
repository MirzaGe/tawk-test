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
}

final class UserTableDataSource: NSObject, UserTableDataSourceEvents {
    
    typealias Data = UserFormatter
    typealias Cell = UserTableViewCell
    
    var data: BehaviorRelay<[Data]> = BehaviorRelay(value: [])
    
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
    
    
    let disposeBag = DisposeBag()
    
}

extension UserTableDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: Cell.self, for: indexPath)
        
        let isInverted = (((indexPath.row + 1) % 4) == 0)
        cell.configure(data: data.value[indexPath.row], isInverted: isInverted)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == (self.data.value.count - 1) {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = spinner
            
            self._loadMore.accept(())
            
        }
        
    }
    
}
