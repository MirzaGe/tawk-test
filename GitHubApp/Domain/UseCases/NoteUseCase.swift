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
    func saveNote(params: GetUserParameters, completionHandler: @escaping NoteUseCaseCompletionHandler)
}

struct SaveNoteParameters {
    
}
