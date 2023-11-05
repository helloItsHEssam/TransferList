//
//  PersonDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

class PersonDTO: NSObject, NSSecureCoding, Decodable {
    
    enum Key: String {
        case fullName
        case email
        case avatar
    }

    static var supportsSecureCoding: Bool = true
    var full_name: String?
    var email: String?
    var avatar: String?
    
    init(full_name: String? = nil, email: String? = nil, avatar: String? = nil) {
        self.full_name = full_name
        self.email = email
        self.avatar = avatar
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(full_name, forKey: Key.fullName.rawValue)
        coder.encode(email, forKey: Key.email.rawValue)
        coder.encode(avatar, forKey: Key.avatar.rawValue)
    }
    
    required convenience init?(coder: NSCoder) {
        let full_name = coder.decodeObject(of: NSString.self,
                                           forKey: Key.fullName.rawValue) as? String
        let email = coder.decodeObject(of: NSString.self,
                                       forKey: Key.email.rawValue) as? String
        let avatar = coder.decodeObject(of: NSString.self,
                                        forKey: Key.avatar.rawValue) as? String

        self.init(full_name: full_name, email: email, avatar: avatar)
    }
}
