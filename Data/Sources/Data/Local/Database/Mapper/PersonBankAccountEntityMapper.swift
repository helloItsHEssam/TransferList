//
//  PersonBankAccountEntityMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import CoreData

struct PersonBankAccountEntityMapper: Mapper {
    
    typealias Entity = PersonBankAccountEntity
    typealias Dto = PersonBankAccountDTO
    
    private let context: NSManagedObjectContext
    private let cardEntityMapper: CardEntityMapper
    private let personEntityMapper: PersonEntityMapper
    
    init(context: NSManagedObjectContext,
         cardEntityMapper: CardEntityMapper,
         personEntityMapper: PersonEntityMapper) {
        self.context = context
        self.cardEntityMapper = cardEntityMapper
        self.personEntityMapper = personEntityMapper
    }
    
    func mapDtoToEntity(input: PersonBankAccountDTO) -> PersonBankAccountEntity {
        let entity = PersonBankAccountEntity(context: context)
        entity.person = personEntityMapper.mapDtoToEntity(input: input.person)
        entity.moreInfo = input.moreInfo
        entity.card = cardEntityMapper.mapDtoToEntity(input: input.card)
        entity.note = input.note
        entity.lastTransfer = input.lastTransfer
        entity.dateSaved = Date()
        
        return entity
    }
    
    func mapEntityToDto(input: PersonBankAccountEntity) -> PersonBankAccountDTO {
        let person = personEntityMapper.mapEntityToDto(input: input.person)
        let card = cardEntityMapper.mapEntityToDto(input: input.card)
        return .init(person: person, card: card,
                     moreInfo: input.moreInfo, note: input.note,
                     lastTransfer: input.lastTransfer, isFavorite: input.isFavorite)
    }
}
