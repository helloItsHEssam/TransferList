//
//  Router.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation
import Domain

enum Router: Hashable, Equatable {
    
    case home
    case detail(account: PersonBankAccount)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home: hasher.combine("home")
        case .detail(let account): hasher.combine(account)
        }
    }
    
    static func == (lhs: Router, rhs: Router) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
