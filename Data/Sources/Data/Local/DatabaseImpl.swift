//
//  DatabaseImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import CoreData

public class DatabaseImpl: Database {

    private(set) var modelName = "db"
    private var persistentContainer: PersistentContainer!
    
    public required init() {
        setupPersistentContainer()
        
        PersonDTOTransformer.register()
        CardDTOTransformer.register()
        CardTransferCountDTOTransformer.register()
    }

    public lazy var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        return context
    }()

    public lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    private func setupPersistentContainer() {
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "momd") else { return }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return }
        
        let container = PersistentContainer(name: modelName, managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        persistentContainer = container
    }
}
