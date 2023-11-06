//
//  PersonBankAccountMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Domain

struct PersonBankAccountMapper: Mapper {
    
    typealias Entity = PersonBankAccount
    typealias Dto = PersonBankAccountDTO
    
    private let personMapper: PersonMapper
    private let cardMapper: CardMapper
    private let cardTransferCountMapper: CardTransferCountMapper
    
    init(personMapper: PersonMapper, cardMapper: CardMapper,
         cardTransferCountMapper: CardTransferCountMapper) {
        self.personMapper = personMapper
        self.cardMapper = cardMapper
        self.cardTransferCountMapper = cardTransferCountMapper
    }
    
    func mapDtoToEntity(input: PersonBankAccountDTO) -> PersonBankAccount {
        let person = personMapper.mapDtoToEntity(input: input.person)
        let card = cardMapper.mapDtoToEntity(input: input.card)
        let transferCount = cardTransferCountMapper.mapDtoToEntity(input: input.moreInfo)
        return .init(person: person, card: card, cardTransferCount: transferCount, note: input.note,
                     lastDateTransfer: input.lastTransfer)
    }
    
    func mapEntityToDto(input: PersonBankAccount) -> PersonBankAccountDTO {
        let person = personMapper.mapEntityToDto(input: input.person)
        let card = cardMapper.mapEntityToDto(input: input.card)
        let transferCount = cardTransferCountMapper.mapEntityToDto(input: input.cardTransferCount)
        return .init(person: person, card: card, moreInfo: transferCount, note: input.note,
                     lastTransfer: input.lastDateTransfer)
    }
}
