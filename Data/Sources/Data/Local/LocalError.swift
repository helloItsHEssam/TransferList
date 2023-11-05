//
//  LocalError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

enum LocalError: Error {

    case cannotFetchFavorites
    case cannotSavePersonAccountToFavorites
    case cannotRemovePersonAccountFromFavorites
    
    var errorDescription: String? {
        switch self {
        case .cannotFetchFavorites: return "caanot fetch favorites accounts"
        case .cannotSavePersonAccountToFavorites: return "Failed to save person accounts to favorites"
        case .cannotRemovePersonAccountFromFavorites: return "Failed to remove person account from favorites"
        }
    }
}
