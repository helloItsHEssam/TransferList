//
//  Database.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import CoreData

public protocol Database {

    var viewContext: NSManagedObjectContext { set get }
    var backgroundContext: NSManagedObjectContext { get }
    func saveContext() throws
    func saveBackgroundContext() throws
}

public extension Database {

    func saveContext() throws {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            throw DatabaseError.unexpectedError
        }
    }

    func saveBackgroundContext() throws {
        guard backgroundContext.hasChanges else { return }
        do {
            try backgroundContext.save()
            try saveContext()
        } catch {
            throw DatabaseError.unexpectedError
        }
    }
}
