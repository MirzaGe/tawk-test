//
//  Note+CoreDataClass.swift
//  
//
//  Created by John Roque Jorillo on 6/27/20.
//
//

import Foundation
import CoreData


public class CoreDataNote: NSManagedObject {
}

extension CoreDataNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataNote> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var userId: Int32
    @NSManaged public var note: String?

}
