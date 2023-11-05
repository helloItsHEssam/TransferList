//
//  CardMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Domain

struct CardMapper: Mapper {
    
    typealias Entity = Card?
    typealias Dto = CardDTO?
    
    func mapDtoToEntity(input: CardDTO?) -> Card? {
        guard let input else { return nil }
        return .init(cardNumber: input.cardNumber, cardType: input.cardType)
    }
    
    func mapEntityToDto(input: Card?) -> CardDTO? {
        guard let input else { return nil }
        return .init(cardNumber: input.cardNumber, cardType: input.cardType)
    }
}
