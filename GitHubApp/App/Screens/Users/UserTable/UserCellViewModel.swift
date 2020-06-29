//
//  UserCellViewModel.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/29/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

protocol UserCellViewModel {
    
    func dequeueCell(tableView: UITableView, indexPath: IndexPath)
    
}
