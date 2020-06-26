//
//  UsersViewModel.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// make this events bind with UI events
protocol UsersViewModelInputs {
    func outputs() -> UsersViewModelOutputs
    func getUsers()
}

protocol UsersViewModelOutputs {
    var users: BehaviorRelay<[UserFormatter]> { get }
}

class UsersViewModel: UsersViewModelOutputs {
    
    fileprivate var getUsersUseCase: GetUsersUseCase
    
    init(getUsersUseCase: GetUsersUseCase) {
        self.getUsersUseCase = getUsersUseCase
    }
    
    let users: BehaviorRelay<[UserFormatter]> = BehaviorRelay(value: [])
 
    // MARK: - Data properties
    private var _sinceUserId: Int = 0
    private var _users: [User] = []
    
}

extension UsersViewModel: UsersViewModelInputs {
    
    func outputs() -> UsersViewModelOutputs {
        return self
    }
    
    func getUsers() {
        
        self._sinceUserId = 0
        self._users.removeAll()
        
        let params = GetUsersParameters(since: _sinceUserId)
        
        self.getUsersUseCase.getUsers(params: params) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self._users.append(contentsOf: users)
                self.users.accept(self._users.map { UserFormatter(user: $0) } )
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            
        }
        
    }
    
}
