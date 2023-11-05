//
//  PersonBankAccountUseCaseImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation
import Combine

public class PersonBankAccountUseCaseImpl: PersonBankAccountUseCase {
    
    private var repository: PersonBankAccountRepository
    
    public init(repository: PersonBankAccountRepository) {
        self.repository = repository
    }
    
    public func fetchPersonAccounts(withOffest offset: Int)
    -> AnyPublisher<[PersonBankAccount], PersonBankAccountError> {
        return AnyPublisher { [weak self] in
            guard let self else { throw PersonBankAccountError.cannotFetchPersonAccounts }
            
            do {
                let accounts = try await self.repository.fetchPersonAccounts(withOffest: offset)
                let newAccount = await self.updateFavoriteStatus(forPersonBankAccounts: accounts)
                return newAccount
            } catch {
                throw PersonBankAccountError.cannotFetchPersonAccounts
            }
        }
    }
    
    public func fetchFavoritePersonAccounts()
    -> AnyPublisher<[PersonBankAccount], PersonBankAccountError> {
        return AnyPublisher { [weak self] in
            guard let self else { throw PersonBankAccountError.cannotFetchFavoritePersonAccounts }
            
            do {
                return try await self.repository.fetchFavoritePersonAccounts()
            } catch {
                throw PersonBankAccountError.cannotFetchFavoritePersonAccounts
            }
        }
    }
    
    public func savePersonAccountToFavorites(_ personBankAccount: PersonBankAccount)
    -> AnyPublisher<PersonBankAccount, PersonBankAccountError> {
        return AnyPublisher { [weak self] in
            guard let self else { throw PersonBankAccountError.cannotSavePersonAccountToFavorites }
            
            do {
                return try await self.repository.savePersonAccountToFavorites(personBankAccount)
            } catch {
                throw PersonBankAccountError.cannotSavePersonAccountToFavorites
            }
        }
    }
    
    public func removePersonAccountFromFavorites(_ personBankAccount: PersonBankAccount)
    -> AnyPublisher<PersonBankAccount, PersonBankAccountError> {
        return AnyPublisher { [weak self] in
            guard let self else { throw PersonBankAccountError.cannotRemovePersonAccountFromFavorites }
            
            do {
                return try await self.repository.removePersonAccountFromFavorites(personBankAccount)
            } catch {
                throw PersonBankAccountError.cannotRemovePersonAccountFromFavorites
            }
        }
    }
    
    private func updateFavoriteStatus(forPersonBankAccounts accounts: [PersonBankAccount]) async
    -> [PersonBankAccount] {
        return await withTaskGroup(of: PersonBankAccount.self,
                      returning: [PersonBankAccount].self) { [weak self] taskGroup in
            guard let self else { return accounts }
            
            var updatedFavoriteStatusAccounts = accounts
            
            let totalSize = accounts.count
            let batchSize = totalSize < 4 ? totalSize : 4
            
            func createUpdateFavoriteStatusTask(atIndex index: Int) {
                taskGroup.addTask {
                    var updatedAccount = await self.repository
                        .updatefavoriteStatusBasedOnFavorites(accounts[index])
                    updatedAccount.update(indexAtList: index)
                    return updatedAccount
                }
            }

            for index in 0 ..< batchSize {
                createUpdateFavoriteStatusTask(atIndex: index)
            }
            
            var index = batchSize
            
            for await account in taskGroup {
                updatedFavoriteStatusAccounts[account.indexAtList].update(favoriteStatus: account.isFavorite)
                
                if index < totalSize {
                    createUpdateFavoriteStatusTask(atIndex: index)
                    index += 1
                }
            }
            return updatedFavoriteStatusAccounts
        }
    }
}
