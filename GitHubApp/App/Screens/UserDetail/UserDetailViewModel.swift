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
    func saveNote(_ value: String)
}

protocol UserDetailViewModelOutputs {
    var user: PublishRelay<UserFormatter> { get }
    var message: PublishRelay<String> { get }
    var error: PublishRelay<String> { get }
}

class UserDetailViewModel: UserDetailViewModelOutputs {
    
    fileprivate var getUserUseCase: GetUserUseCase
    fileprivate var noteUseCase: NoteUseCase
    private var _user: UserFormatter
    
    init(getUserUseCase: GetUserUseCase,
         noteUseCase: NoteUseCase,
         user: UserFormatter) {
        self.getUserUseCase = getUserUseCase
        self.noteUseCase = noteUseCase
        self._user = user
    }
    
    let user: PublishRelay<UserFormatter> = PublishRelay()
    let message: PublishRelay<String> = PublishRelay()
    let error: PublishRelay<String> = PublishRelay()
    
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
                self.error.accept(error.localizedDescription)
            }
            
        }
        
    }
    
    func saveNote(_ value: String) {
        
        let params = SaveNoteParameters(userId: _user.getId(), note: value)
        
        self.noteUseCase.saveNote(params: params) {
            [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.message.accept("Note added.")
            case .failure(let error):
                self.error.accept(error.localizedDescription)
            }
        }
        
    }
    
}
