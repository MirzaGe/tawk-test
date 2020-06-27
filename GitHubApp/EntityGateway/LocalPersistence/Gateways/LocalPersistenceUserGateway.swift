//
//  LocalPersistenceUserGateway.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

protocol LocalPersistenceUserGateway: NoteGateway {
}

class CoreDataGatewayImpl: LocalPersistenceUserGateway {
    
    let localPersistence: CoreDataStackImplementation
    
    init(localPersistence: CoreDataStackImplementation) {
        self.localPersistence = localPersistence
    }
    
    func saveNote(params: SaveNoteParameters, completionHandler: @escaping NoteUseCaseCompletionHandler) {
        
        self.localPersistence.saveNote(userId: params.userId, note: params.note)
        
        completionHandler(.success(()))
        
    }
    
}
