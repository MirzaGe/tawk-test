//
//  UsersViewController.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupNav()
        setupView()
    }
    
    private func setupNav() {
        self.title = AppStrings.usersScreenTitle.rawValue.getLocalize()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupView() {
        self.view.backgroundColor = AppColors.backgroundColor.value
    }

}
