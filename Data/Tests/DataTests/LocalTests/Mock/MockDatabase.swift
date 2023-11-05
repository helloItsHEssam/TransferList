//
//  MockDatabase.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import CoreData
@testable import Data

final class MockDatabase: DatabaseImpl {
    
    required init() {
        super.init()
        
        viewContext = createInMemoryViewContext()
    }

    private func createInMemoryViewContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        return context
    }
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.module.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try coordinator.addPersistentStore(ofType: NSInMemoryStoreType,
                                               configurationName: nil,
                                               at: nil,
                                               options: nil)
        } catch {
            fatalError("Failed to initialize in-memory store type: \(error)")
        }
        return coordinator
    }()
}

