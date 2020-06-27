//
//  NoteUseCase.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

typealias NoteUseCaseCompletionHandler = (_ user: Result<Void, Error>) -> Void

protocol NoteUseCase {
    func saveNote(params: SaveNoteParameters, completionHandler: @escaping NoteUseCaseCompletionHandler)
}

struct SaveNoteParameters {
    let userId: Int
    let note: String
}

class NoteUseCaseImpl: NoteUseCase {
    
    let gateway: NoteGateway
    
    init(gateway: NoteGateway) {
        self.gateway = gateway
    }
    
    func saveNote(params: SaveNoteParameters, completionHandler: @escaping NoteUseCaseCompletionHandler) {
        
        self.gateway.saveNote(params: params) { (result) in
            completionHandler(result)
        }
        
    }
    
}
