//
//  DatabaseTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import XCTest
@testable import Data
import CoreData

final class DatabaseTests: XCTestCase {

    var database: Database!
    
    override func tearDown() {
        database = nil
    }
    
    private func createPersonAccountEntity(inContext: NSManagedObjectContext) {
        let account = PersonBankAccountEntity(context: inContext)
        let dateSaved = Date()
        let note = "note"
        account.dateSaved = dateSaved
        account.note = note
        account.lastTransfer = nil
        account.person = PersonDTO(full_name: "hessam", email: "h.mahdi", avatar: nil)
        account.card = .init(card_number: "123", card_type: "master")
        account.more_info = .init(number_of_transfers: 1, total_transfer: nil)
    }
    
    func testSavePersonAccount() {
        database = MockDatabase()
        
        database.backgroundContext.performAndWait {
            createPersonAccountEntity(inContext: database.backgroundContext)

            do {
                try database.saveBackgroundContext()

                let fetchRequest:
                NSFetchRequest<PersonBankAccountEntity> = PersonBankAccountEntity.fetchRequest()
                let sort = PersonBankAccountEntity.sortDescriptor
                fetchRequest.sortDescriptors = [sort]

                let results = try database.backgroundContext.fetch(fetchRequest)
                if results.isEmpty {
                    throw DatabaseError.unexpectedError
                } else {

                    XCTAssertEqual(results.count, 1)
                    XCTAssertEqual(results.first?.note, "note")
                    XCTAssertEqual(results.first?.person?.full_name, "hessam")
                    XCTAssertEqual(results.first?.card?.card_number, "123")
                    XCTAssertEqual(results.first?.more_info?.number_of_transfers, 1)
                }

            } catch {
                XCTAssertNil(error)
            }
        }
    }
    
    func testRemovePersonAccount() {
        database = MockDatabase()
        
        database.backgroundContext.performAndWait {
            createPersonAccountEntity(inContext: database.backgroundContext)

            do {
                try database.saveBackgroundContext()

                let fetchRequest:
                NSFetchRequest<PersonBankAccountEntity> = PersonBankAccountEntity.fetchRequest()
                let sort = PersonBankAccountEntity.sortDescriptor
                fetchRequest.sortDescriptors = [sort]

                let account = try database.backgroundContext.fetch(fetchRequest).first!
                
                database.backgroundContext.delete(account)
                                
                let results = try database.backgroundContext.fetch(fetchRequest)
                XCTAssertTrue(results.isEmpty)

            } catch {
                XCTAssertNil(error)
            }
        }
    }
}
