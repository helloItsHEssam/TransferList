//
//  PersonMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Domain

struct PersonMapper: Mapper {
    
    typealias Entity = Person?
    typealias Dto = PersonDTO?
    
    func mapDtoToEntity(input: PersonDTO?) -> Person? {
        guard let input else { return nil }
        return .init(name: input.fullName, email: input.email,
                     avatar: input.avatar)
    }
    
    func mapEntityToDto(input: Person?) -> PersonDTO? {
        guard let input else { return nil }
        return .init(fullName: input.name, email: input.email,
                     avatar: input.avatar)
    }
}
