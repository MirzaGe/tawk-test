//
//  MainCoordinator.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

class MainCoordinator: CoordinatorType {
    
    var childCoordinators: [CoordinatorType] = []
    
    // MARK: - Navigation
    lazy var navigationVc: UINavigationController = {
        let navigationVc = UINavigationController(rootViewController: UIViewController())
        return navigationVc
    }()
    
    // MARK: - Screens
    
    
    func start() {
        
    }
    
}
