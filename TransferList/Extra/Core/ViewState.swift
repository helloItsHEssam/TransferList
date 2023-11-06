//
//  ViewState.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation

enum ViewState: Hashable, Equatable {
    
    case loading
    case result
    case error(message: String)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .error: hasher.combine("error")
        case .result: hasher.combine("result")
        case .loading: hasher.combine("loading")
        }
    }
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
