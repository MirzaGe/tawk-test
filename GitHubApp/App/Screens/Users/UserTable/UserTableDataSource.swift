//
//  UserTableDataSource.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

final class UserTableDataSource: NSObject {
    
    typealias Data = String
    typealias Cell = UserTableViewCell
    
    private weak var tableView: UITableView?
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
    }
    
}

extension UserTableDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: Cell.self, for: indexPath)
        
        return cell
    }
    
}
