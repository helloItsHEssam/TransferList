//
//  PersonDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

struct PersonDTO: Decodable {
    
    var fullName: String?
    var email: String?
    var avatar: String?
    
    init(fullName: String? = nil, email: String? = nil, avatar: String? = nil) {
        self.fullName = fullName
        self.email = email
        self.avatar = avatar
    }
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email = "email"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
    }
}
