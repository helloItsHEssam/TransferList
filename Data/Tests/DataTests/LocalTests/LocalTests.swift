//
//  LocalTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import XCTest
import Domain
@testable import Data

final class LocalTests: XCTestCase {

    private var local: Local!
    
    override func tearDown() {
        local = nil
    }
    
    private func createBankAccount() -> PersonBankAccount {
        let person = Person(name: "hessam", email: "h.mahdi", avatar: nil)
        let card = Card(cardNumber: "123", cardType: "master")
        let cardCount = CardTransferCount(numberOfTransfers: 12, totalTransfer: 12)
        let note = "note"
        return .init(person: person, card: card,
                     cardTransferCount: cardCount, note: note, lastDateTransfer: nil)
    }
    
    func testSuccessSaveAccountToFavorites() async {

        // given
        local = LocalImpl(database: MockDatabase())
        
        // when
        do {
            let account = try await local.savePersonAccountToFavorites(createBankAccount())
            
            XCTAssertEqual(account.isFavorite, true)
            XCTAssertEqual(account.person?.name, "hessam")
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
    
    func testSuccessRemoveAccountToFavorites() async {

        // given
        local = LocalImpl(database: MockDatabase())
        
        // when
        do {
            let account = try await local.savePersonAccountToFavorites(createBankAccount())
            let removedAccount = try await local.removePersonAccountFromFavorites(account)
            
            XCTAssertEqual(removedAccount.isFavorite, false)
            XCTAssertEqual(account.person?.name, "hessam")
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
    
    func testSuccessFetchFavoriteAccounts() async {
        
        // given
        local = LocalImpl(database: MockDatabase())
        
        // when
        do {
            let _ = try await local.savePersonAccountToFavorites(createBankAccount())            
            let accounts = try await local.fetchFavoritePersonAccounts()
            
            XCTAssertEqual(accounts.count, 1)
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
}
