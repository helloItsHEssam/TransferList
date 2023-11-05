//
//  PersonBankAccountRepositoryImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Domain

public class PersonBankAccountRepositoryImpl: PersonBankAccountRepository {
    
    private var api: Api
    private let mapper: PersonBankAccountMapper
    
    public init(api: Api) {
        self.api = api
        mapper = .init(personMapper: .init(),
                       cardMapper: .init(),
                       cardTransferCountMapper: .init())
    }
    
    public func fetchPersonAccounts(withOffest offset: Int) async throws -> [Domain.PersonBankAccount] {
        let accounts = try await api.callApi(route: .transferList(offset: offset),
                                             decodeType: [PersonBankAccountDTO].self)
        return mapper.mapDtosToEntities(input: accounts)
    }
    
    public func fetchFavoritePersonAccounts() async throws -> [Domain.PersonBankAccount] {
        fatalError()
    }
    
    public func savePersonAccountToFavorites(_ personBankAccount: Domain.PersonBankAccount) async throws -> Domain.PersonBankAccount {
        fatalError()
    }
    
    public func removePersonAccountFromFavorites(_ personBankAccount: Domain.PersonBankAccount) async throws -> Domain.PersonBankAccount {
        fatalError()
    }
    
    public func updatefavoriteStatusForPersonAccount(_ personBankAccount: Domain.PersonBankAccount) async -> Domain.PersonBankAccount {
        fatalError()
    }
}
