//
//  PersonBankAccountDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

struct PersonBankAccountDTO: Decodable {
    
    var person: PersonDTO?
    var card: CardDTO?
    var more_info: CardTransferCountDTO?
    var note: String?
    var last_transfer: Date?
    var isFavorite: Bool = false
    
    init(person: PersonDTO?, card: CardDTO?, more_info: CardTransferCountDTO?, note: String?,
         last_transfer: Date?, isFavorite: Bool = false) {
        self.person = person
        self.card = card
        self.more_info = more_info
        self.note = note
        self.last_transfer = last_transfer
        self.isFavorite = isFavorite
    }
    
    enum CodingKeys: CodingKey {
        case person
        case card
        case more_info
        case note
        case last_transfer
        case isFavorite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.person = try container.decodeIfPresent(PersonDTO.self, forKey: .person)
        self.card = try container.decodeIfPresent(CardDTO.self, forKey: .card)
        self.more_info = try container.decodeIfPresent(CardTransferCountDTO.self, forKey: .more_info)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        self.last_transfer = try container.decodeIfPresent(Date.self, forKey: .last_transfer)
    }
}
