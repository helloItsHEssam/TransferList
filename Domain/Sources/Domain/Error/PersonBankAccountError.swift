//
//  PersonBankAccountError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation

public enum PersonBankAccountError: Error {
    
    case cannotSavePersonAccountToFavorites
    case cannotRemovePersonAccountFromFavorites
    case cannotFetchPersonAccounts
    case cannotFetchFavoritePersonAccounts
    case unexpectedError
    
    var errorDescription: String? {
        switch self {
        case .cannotSavePersonAccountToFavorites:
            return "Failed to save person accounts to favorites"
            
        case .cannotRemovePersonAccountFromFavorites:
            return "Failed to remove person account from favorites"
            
        case .cannotFetchPersonAccounts:
            return "Failed to fetch person accounts"
            
        case .cannotFetchFavoritePersonAccounts:
            return "Failed to fetch favorite person accounts"
            
        case .unexpectedError: return "Unexpected error"
        }
    }
}
