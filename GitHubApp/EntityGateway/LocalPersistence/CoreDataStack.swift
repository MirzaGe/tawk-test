//
//  CoreDataStack.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation
import CoreData

// This need refactoring

protocol CoreDataStack {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
}

class CoreDataStackImplementation {
    
    static let sharedInstance = CoreDataStackImplementation()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "GitHubApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearUsersStorage() {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func saveUsers(users: [User]) {
        var cdUsers: [CDUser] = []

        for user in users {
            let entity = NSEntityDescription.entity(forEntityName: "CDUser", in: persistentContainer.viewContext)
            let newUser = NSManagedObject(entity: entity!, insertInto: persistentContainer.viewContext) as! CDUser
            newUser.setData(user: user)
            cdUsers.append(newUser)
        }
        
        saveContext()
    }
    
    func getUsers() -> [CDUser] {
        
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users
        } catch let error {
            print(error)
        }
        
        return []
        
    }
    
    func getUser(username: String) -> CDUser? {
        
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
        
        let predicate = NSPredicate(format: "login == '\(username)'")
        fetchRequest.predicate = predicate
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users.first
        } catch let error {
            print(error)
            return nil
        }
        
    }
    
    func updateUser(user: User) {
        
        guard let cdUser = getUser(username: user.login ?? "") else {
            return
        }
        
        cdUser.setData(user: user)
        
        saveContext()
        
    }
    
    func getNote(userId: Int) -> CDNote? {
        
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CDNote>(entityName: "CDNote")
        
        let predicate = NSPredicate(format: "userId == \(userId)")
        fetchRequest.predicate = predicate
        
        do {
            let notes = try managedObjectContext.fetch(fetchRequest)
            return notes.first
        } catch let error {
            print(error)
            return nil
        }
        
    }
    
    func saveNote(userId: Int, note: String) {
        
        guard let cdNote = getNote(userId: userId) else { return }
        
        cdNote.note = note
        
        print("Note saved!!!")
        
        saveContext()
        
    }
    
}
