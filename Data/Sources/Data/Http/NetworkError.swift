//
//  File.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
    
    case cannotConnectToServer
    case cannotParseJson
    case serverError(message: ResponseError)
    
    var errorDescription: String? {
        switch self {
        case .cannotConnectToServer: return "You seem to be offline!"
        case .cannotParseJson: return "Unexpected error"
        case .serverError(let error): return String(describing: error)
        }
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.cannotConnectToServer, .cannotConnectToServer): return true
        case (.cannotParseJson, .cannotParseJson): return true
        case (.serverError(let lhsError), .serverError(let rhsError)): return lhsError == rhsError
        default: return false
        }
    }
}
