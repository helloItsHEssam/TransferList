//
//  DatabaseImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import CoreData

public class DatabaseImpl: Database {

    private let modelName = "db"
    public private(set) var persistentContainer: NSPersistentContainer!
    
    public required init() {        
        setupPersistentContainer()
    }

    lazy public var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        return context
    }()

    lazy public var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    private func setupPersistentContainer() {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        persistentContainer = container
    }
}
