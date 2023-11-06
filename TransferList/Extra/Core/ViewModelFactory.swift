//
//  ViewModelFactory.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation

class ViewModelFactory {
    
    private var container: DIContainer!
    
    static let shared = ViewModelFactory()
    
    private init() {}
    
    func register(DIContainer container: DIContainer) {
        self.container = container
    }

    func createMediaViewModel() -> TransferViewModel {
        guard container != nil else {
            fatalError("Register DIContainer to Enable ViewModel Creation")
        }
        
        let personBankAccountUseCase = container.createPresonBankAccountUseCase()
        return .init(personBackAccountUseCase: personBankAccountUseCase)
    }
}
