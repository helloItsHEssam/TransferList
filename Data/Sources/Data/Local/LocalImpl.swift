//
//  LocalImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Domain
import CoreData

public class LocalImpl: Local {

    private let database: Database
    private let coreDataMapper: PersonBankAccountEntityMapper
    private let mapper: PersonBankAccountMapper
    
    public init(database: Database) {
        self.database = database
        
        let context = database.backgroundContext
        let personMapper = PersonEntityMapper(context: context)
        let cardMapper = CardEntityMapper(context: context)
        coreDataMapper = .init(context: context,
                               cardEntityMapper: cardMapper,
                               personEntityMapper: personMapper)
        
        mapper = .init(personMapper: .init(), cardMapper: .init(),
                       cardTransferCountMapper: .init())
    }
    
    public func fetchFavoritePersonAccounts() async throws -> [Domain.PersonBankAccount] {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: LocalError.cannotFetchFavorites)
                return
            }
            
            self.database.backgroundContext.performAndWait { [weak self] in
                guard let self else {
                    continuation.resume(throwing: LocalError.cannotFetchFavorites)
                    return
                }
                
                do {
                    let fetchRequest:
                    NSFetchRequest<PersonBankAccountEntity> = PersonBankAccountEntity.fetchRequest()
                    let sort = PersonBankAccountEntity.sortDescriptor
                    fetchRequest.sortDescriptors = [sort]

                    let accountMangedObjects = try self.database.backgroundContext.fetch(fetchRequest)
                    let accountDtos = self.coreDataMapper.mapEntitiesToDtos(input: accountMangedObjects)
                    let accounts = self.mapper
                        .mapDtosToEntities(input: accountDtos)
                        .map { item in
                            var changeToFavoriteItem = item
                            changeToFavoriteItem.update(favoriteStatus: true)
                            return changeToFavoriteItem
                        }
                    
                    continuation.resume(returning: accounts)
                    
                } catch {
                    continuation.resume(throwing: LocalError.cannotFetchFavorites)
                }
            }
        }
    }
    
    public func savePersonAccountToFavorites(_ personBankAccount: Domain.PersonBankAccount) async throws
    -> Domain.PersonBankAccount {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: LocalError.cannotSavePersonAccountToFavorites)
                return
            }
            
            self.database.backgroundContext.performAndWait { [weak self] in
                guard let self else {
                    continuation.resume(throwing: LocalError.cannotFetchFavorites)
                    return
                }
                
                do {
                    let accountDto = self.mapper.mapEntityToDto(input: personBankAccount)
                    let _ = self.coreDataMapper.mapDtoToEntity(input: accountDto)
                    
                    try Task.checkCancellation()
                    try self.database.saveBackgroundContext()
                    
                    var newPersonBankAccount = personBankAccount
                    newPersonBankAccount.update(favoriteStatus: true)
                    continuation.resume(returning: newPersonBankAccount)
                    
                } catch {
                    self.database.backgroundContext.rollback()
                    continuation.resume(throwing: LocalError.cannotSavePersonAccountToFavorites)
                }
            }
        }
    }
    
    public func removePersonAccountFromFavorites(_ personBankAccount: Domain.PersonBankAccount) async throws
    -> Domain.PersonBankAccount {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: LocalError.cannotRemovePersonAccountFromFavorites)
                return
            }
            
            self.database.backgroundContext.performAndWait { [weak self] in
                guard let self else {
                    continuation.resume(throwing: LocalError.cannotRemovePersonAccountFromFavorites)
                    return
                }
                
                do {
                    let fetchRequest:
                    NSFetchRequest<PersonBankAccountEntity> = PersonBankAccountEntity.fetchRequest()
                    let sort = PersonBankAccountEntity.sortDescriptor
                    fetchRequest.sortDescriptors = [sort]
                    fetchRequest.fetchLimit = 1
                    
                    let namePredicate = NSPredicate(format: "person.name == %@",
                                                    personBankAccount.person?.name ?? "")
                    let cardNumberPredicate = NSPredicate(format: "card.cardNumber == %@",
                                                          personBankAccount.card?.cardNumber ?? "")
                    let predicate = NSCompoundPredicate(type: .and,
                                                        subpredicates: [namePredicate, cardNumberPredicate])
                    fetchRequest.predicate = predicate

                    try Task.checkCancellation()
                    let accounts = try self.database.backgroundContext.fetch(fetchRequest)
                    guard let entity = accounts.first else {
                        continuation.resume(throwing: LocalError.cannotRemovePersonAccountFromFavorites)
                        return
                    }
                    
                    try Task.checkCancellation()
                    self.database.backgroundContext.delete(entity)
                    try self.database.saveBackgroundContext()
                    
                    var newPersonBankAccount = personBankAccount
                    newPersonBankAccount.update(favoriteStatus: false)
                    continuation.resume(returning: newPersonBankAccount)
                    
                } catch {
                    self.database.backgroundContext.rollback()
                    continuation.resume(throwing: LocalError.cannotRemovePersonAccountFromFavorites)
                }
            }
        }
    }
}
