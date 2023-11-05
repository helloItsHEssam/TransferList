//
//  MockRepository.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
@testable import Domain

class MockPersonBankAccountRepository: PersonBankAccountRepository {
    
    func createMockPersonAccount() -> PersonBankAccount {
        let person = Person(name: "hessam", email: "h.mahdi", avatar: nil)
        let card = Card(cardNumber: "123", cardType: "master")
        let cardCount = CardTransferCount(numberOfTransfers: 12, totalTransfer: 12)
        let note = "note"
        return .init(person: person, card: card, cardTransferCount: cardCount,
                     note: note, lastDateTransfer: nil)
    }
    
    func fetchPersonAccounts(withOffest offset: Int) async throws -> [Domain.PersonBankAccount] {
        throw MockError.mockCase
    }
    
    func fetchFavoritePersonAccounts() async throws -> [Domain.PersonBankAccount] {
        throw MockError.mockCase
    }
    
    func savePersonAccountToFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount {
        throw MockError.mockCase
    }
    
    func removePersonAccountFromFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount {
        throw MockError.mockCase
    }
    
    func updatefavoriteStatusForPersonAccount(_ personBankAccount: Domain.PersonBankAccount) async -> Domain.PersonBankAccount {
        return personBankAccount
    }
}

class MockSuccessEmptyFetchAccountRepository: MockPersonBankAccountRepository {
    override func fetchPersonAccounts(withOffest offset: Int) async throws -> [PersonBankAccount] {
        return []
    }
}

class MockSuccessFetchAccountRepository: MockPersonBankAccountRepository {
    
    override func fetchPersonAccounts(withOffest offset: Int) async throws -> [PersonBankAccount] {
        return [createMockPersonAccount()]
    }
    
    override func fetchFavoritePersonAccounts() async throws -> [PersonBankAccount] {
        var person = createMockPersonAccount()
        person.update(favoriteStatus: true)
        return [person]
    }
}

class MockSuccessSaveOrRemoveAccountToFavoritesRepository: MockPersonBankAccountRepository {
    
    var person: PersonBankAccount!
    
    override func savePersonAccountToFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount {
        person = personBankAccount
        person.update(favoriteStatus: true)
        return person
    }
    
    override func removePersonAccountFromFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount {
        person = personBankAccount
        person.update(favoriteStatus: false)
        return person
    }
    
    override func fetchFavoritePersonAccounts() async throws -> [PersonBankAccount] {
        return [person]
    }
}
