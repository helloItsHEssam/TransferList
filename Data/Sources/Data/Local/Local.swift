//
//  Local.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Domain

public protocol Local {
    
    func fetchFavoritePersonAccounts() async throws -> [PersonBankAccount]
    func savePersonAccountToFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount
    func removePersonAccountFromFavorites(_ personBankAccount: PersonBankAccount) async throws -> PersonBankAccount
    func updatefavoriteStatusBasedOnFavorites(_ personBankAccount: PersonBankAccount) async -> PersonBankAccount
}
