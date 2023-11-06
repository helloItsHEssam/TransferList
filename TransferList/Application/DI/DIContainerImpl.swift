//
//  DIContainerImpl.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation
import Domain
import Data

final class DIContainerImpl: DIContainer {

    private func createPersonBankAccountRepository() -> PersonBankAccountRepository {
        let api: Api = ApiImpl()
        let database = DatabaseImpl()
        let local = LocalImpl(database: database)
        
        return PersonBankAccountRepositoryImpl(api: api, local: local)
    }
    
    func createPresonBankAccountUseCase() -> PersonBankAccountUseCase {
        let repository = createPersonBankAccountRepository()
        let useCase = PersonBankAccountUseCaseImpl(repository: repository)
        return useCase
    }
}
