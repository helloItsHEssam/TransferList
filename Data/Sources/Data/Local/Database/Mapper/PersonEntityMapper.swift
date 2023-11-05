//
//  PersonEntityMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import CoreData

struct PersonEntityMapper: Mapper {
    
    typealias Entity = PersonEntity?
    typealias Dto = PersonDTO?
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func mapDtoToEntity(input: PersonDTO?) -> PersonEntity? {
        guard let input else { return nil }
        let entity = PersonEntity(context: context)
        entity.name = input.full_name
        entity.avatar = input.avatar
        entity.email = input.email

        return entity
    }

    func mapEntityToDto(input: PersonEntity?) -> PersonDTO? {
        guard let input else { return nil }
        return .init(full_name: input.name, email: input.email,
                     avatar: input.avatar)
    }
}
