//
//  MockLocal.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Domain
@testable import Data

class MockLocal: Local {
    
    func createAccount() -> PersonBankAccount {
        let person = Person(name: "hessam", email: "h.mahdi", avatar: nil)
        let card = Card(cardNumber: "123", cardType: "master")
        let cardCount = CardTransferCount(numberOfTransfers: 12, totalTransfer: 12)
        let note = "note"
        
        return .init(person: person, card: card,
                     cardTransferCount: cardCount, note: note, lastDateTransfer: nil)
    }
    
    func fetchFavoritePersonAccounts() async throws -> [PersonBankAccount] {
        return [
            createAccount()
        ]
    }
    
    func savePersonAccountToFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount {
        var newAccount = personBankAccount
        newAccount.update(favoriteStatus: true)
        return newAccount
    }
    
    func removePersonAccountFromFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount {
        var newAccount = personBankAccount
        newAccount.update(favoriteStatus: false)
        return newAccount
    }
    
    func updatefavoriteStatusBasedOnFavorites(_ personBankAccount: PersonBankAccount) async -> PersonBankAccount {
        var newAccount = personBankAccount
        newAccount.update(favoriteStatus: true)
        return newAccount
    }
}

class MockSucceesRemoveLocal: MockLocal {
    
    override func fetchFavoritePersonAccounts() async throws -> [PersonBankAccount] {
        []
    }
}

class MockFailSaveOrRemoveLocal: MockSucceesRemoveLocal {
    
    override func savePersonAccountToFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount {
        throw LocalError.cannotSavePersonAccountToFavorites
    }
    
    override func removePersonAccountFromFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount {
        throw LocalError.cannotRemovePersonAccountFromFavorites
    }
}

class MockFailFetchFavoriteAccountLocal: MockLocal {
    
    override func fetchFavoritePersonAccounts() async throws -> [PersonBankAccount] {
        throw LocalError.cannotFetchFavorites
    }
}

class MockDoesNotExistInFavoriteLocal: MockLocal {
    
    override func updatefavoriteStatusBasedOnFavorites(_ personBankAccount: PersonBankAccount) async -> PersonBankAccount {
        var newAccount = personBankAccount
        newAccount.update(favoriteStatus: false)
        return newAccount
    }
}
