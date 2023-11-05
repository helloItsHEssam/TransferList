//
//  PersonBankAccountRepository.swift.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation

public protocol PersonBankAccountRepository {
    
    func fetchPersonAccounts(withOffest offset: Int) async throws -> [PersonBankAccount]
    func fetchFavoritePersonAccounts() async throws -> [PersonBankAccount]
    func savePersonAccountToFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount
    func removePersonAccountFromFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount
    func updatefavoriteStatusBasedOnFavorites(_ personBankAccount: PersonBankAccount) async -> PersonBankAccount
}
