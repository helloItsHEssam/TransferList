//
//  ApiMockResponse.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

struct ApiMockResponse: Hashable, Equatable {

    var url: URL
    var data: Data?
    var httpResponse: HTTPURLResponse?
    var error: Error?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    static func == (lhs: ApiMockResponse, rhs: ApiMockResponse) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
