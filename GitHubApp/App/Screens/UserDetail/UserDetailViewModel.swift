//
//  UserDetailViewModel.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserDetailViewModelInputs {
    func outputs() -> UserDetailViewModelOutputs
    func getUser()
}

protocol UserDetailViewModelOutputs {
    var user: PublishRelay<UserFormatter> { get }
}

class UserDetailViewModel: UserDetailViewModelOutputs {
    
    fileprivate var getUserUseCase: GetUserUseCase
    private var _user: UserFormatter
    
    init(getUserUseCase: GetUserUseCase, user: UserFormatter) {
        self.getUserUseCase = getUserUseCase
        self._user = user
    }
    
    let user: PublishRelay<UserFormatter> = PublishRelay()
    
}

extension UserDetailViewModel: UserDetailViewModelInputs {
    
    func outputs() -> UserDetailViewModelOutputs {
        return self
    }
    
    func getUser() {
        
        let params = GetUserParameters(username: _user.getUsername())
        
        self.getUserUseCase.getUser(params: params) {
            [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self._user = UserFormatter(user: user)
                self.user.accept(self._user)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            
        }
        
    }
    
}
