//
//  File.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case cannotConnectToServer
    case cannotParseJson
    
    var errorDescription: String? {
        switch self {
        case .cannotConnectToServer: return "You seem to be offline!"
        case .cannotParseJson: return "Unexpected error"
        }
    }
}
