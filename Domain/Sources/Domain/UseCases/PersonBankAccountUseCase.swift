//
//  PersonBankAccountUseCase.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation
import Combine

public protocol PersonBankAccountUseCase {

    func fetchPersonAccounts(withOffest offset: Int) -> AnyPublisher<[PersonBankAccount], PersonBankAccountError>
    func fetchFavoritePersonAccounts() -> AnyPublisher<[PersonBankAccount], PersonBankAccountError>
    func savePersonAccountToFavorites(_ personBankAccount: PersonBankAccount)
    -> AnyPublisher<PersonBankAccount, PersonBankAccountError>
    func removePersonAccountFromFavorites(_ personBankAccount: PersonBankAccount)
    -> AnyPublisher<PersonBankAccount, PersonBankAccountError>
}
