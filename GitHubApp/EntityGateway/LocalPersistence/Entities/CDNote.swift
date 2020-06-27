//
//  CDNote+CoreDataClass.swift
//  
//
//  Created by John Roque Jorillo on 6/27/20.
//
//

import Foundation
import CoreData

@objc(CDNote)
public class CDNote: NSManagedObject {

}

extension CDNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNote> {
        return NSFetchRequest<CDNote>(entityName: "CDNote")
    }

    @NSManaged public var userId: Int32
    @NSManaged public var note: String?

}
