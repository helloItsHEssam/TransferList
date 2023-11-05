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
    var moreInfo: CardTransferCountDTO?
    var note: String?
    var lastTransfer: Date?
    var isFavorite: Bool = false
    
    init(person: PersonDTO?, card: CardDTO?, moreInfo: CardTransferCountDTO?, note: String?,
         lastTransfer: Date?, isFavorite: Bool = false) {
        self.person = person
        self.card = card
        self.moreInfo = moreInfo
        self.note = note
        self.lastTransfer = lastTransfer
        self.isFavorite = isFavorite
    }
    
    enum CodingKeys: String, CodingKey {
        case person = "person"
        case card = "card"
        case moreInfo = "more_info"
        case note = "note"
        case lastTransfer = "lastTransfer"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.person = try container.decodeIfPresent(PersonDTO.self, forKey: .person)
        self.card = try container.decodeIfPresent(CardDTO.self, forKey: .card)
        self.moreInfo = try container.decodeIfPresent(CardTransferCountDTO.self, forKey: .moreInfo)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        self.lastTransfer = try container.decodeIfPresent(Date.self, forKey: .lastTransfer)
    }
}
