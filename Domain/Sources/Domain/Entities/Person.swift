//
//  Person.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation

public struct Person {
    
    public var name: String?
    public var email: String?
    public var avatar: String?
    
    public init(name: String?, email: String?, avatar: String?) {
        self.name = name
        self.email = email
        self.avatar = avatar
    }
}
