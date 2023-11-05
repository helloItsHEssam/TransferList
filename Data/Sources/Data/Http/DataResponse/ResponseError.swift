//
//  ResponseError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

struct ResponseError: Decodable, CustomStringConvertible, Equatable {
    
    var message: String?
    
    var description: String {
        return message ?? "Unexpected error"
    }
    
    static func == (lhs: ResponseError, rhs: ResponseError) -> Bool {
        return lhs.message == rhs.message
    }
    
    enum CodingKeys: CodingKey {
        case error
    }
    
    init(message: String?) {
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .error)
    }
}
