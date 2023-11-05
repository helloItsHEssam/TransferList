//
//  CardEntityMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import CoreData

struct CardEntityMapper: Mapper {
    
    typealias Entity = CardEntity?
    typealias Dto = CardDTO?
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func mapDtoToEntity(input: CardDTO?) -> CardEntity? {
        guard let input else { return nil }
        let entity = CardEntity(context: context)
        entity.cardType = input.cardType
        entity.cardNumber = input.cardNumber

        return entity
    }

    func mapEntityToDto(input: CardEntity?) -> CardDTO? {
        guard let input else { return nil }
        return .init(cardNumber: input.cardNumber, cardType: input.cardType)
    }
}
