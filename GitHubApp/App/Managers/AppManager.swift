//
//  AppManager.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

protocol AppManagerServicing {
    func start()
}

class AppManager {
    
    private weak var window: UIWindow?
    private var mainCoordinator: MainCoordinator // make this a protocol
 
    init(window: UIWindow?, mainCoordinator: MainCoordinator) {
        self.window = window
        self.mainCoordinator = mainCoordinator
    }
    
}

extension AppManager: AppManagerServicing {
    
    func start() {
        initWindow()
    }
    
}

extension AppManager {
    
    private func initWindow() {
        window?.rootViewController = mainCoordinator.navigationVc
        window?.makeKeyAndVisible()
        mainCoordinator.start()
    }
    
}
