//
//  DatabaseError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

enum DatabaseError: Error {

    case unexpectedError
    case cannotSavePersonAccountToFavorites
    case cannotRemovePersonAccountFromFavorites
    
    var errorDescription: String? {
        switch self {
        case .unexpectedError: return "You seem to be offline!"
        case .cannotSavePersonAccountToFavorites: return "Failed to save person accounts to favorites"
        case .cannotRemovePersonAccountFromFavorites: return "Failed to remove person account from favorites"
        }
    }
}
