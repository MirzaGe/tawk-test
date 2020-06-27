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
        let navigationVc = UINavigationController(rootViewController: usersVc)
        return navigationVc
    }()
    
    // MARK: - Screens
    lazy var usersVc: UsersViewController = {
        let vc = UsersScreenComposer.composeWith()
        vc.coordinator = self
        return vc
    }()
    
    func start() {
        
    }
    
}

extension MainCoordinator: UsersViewControllerRoute {
    
    func routeToUserDetail(_ vc: UsersViewController, data: UserFormatter) {
        let vc = UserDetailComposer.composeWith(user: data)
        
        self.navigationVc.pushViewController(vc, animated: true)
    }
    
}
