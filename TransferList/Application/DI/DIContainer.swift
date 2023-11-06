//
//  DIContainer.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation
import Domain

protocol DIContainer {
    
    func createPresonBankAccountUseCase() -> PersonBankAccountUseCase
}
