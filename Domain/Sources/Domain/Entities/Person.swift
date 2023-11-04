//
//  Person.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation

public struct Person {
    
    public var name: String?
    public var emial: String?
    public var avatar: String?
    
    public init(name: String?, emial: String?, avatar: String?) {
        self.name = name
        self.emial = emial
        self.avatar = avatar
    }
}
