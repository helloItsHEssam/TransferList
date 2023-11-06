//
//  DatabaseError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

enum DatabaseError: Error {

    case unexpectedError
    
    var errorDescription: String? {
        return "unexpected Error!"
    }
}
