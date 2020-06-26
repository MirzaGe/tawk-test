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

final class UserTableDataSource: NSObject {
    
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
    
}
