//
//  CardDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

struct CardDTO: Decodable {
    
    var cardNumber: String?
    var cardType: String?
    
    init(cardNumber: String? = nil, cardType: String? = nil) {
        self.cardNumber = cardNumber
        self.cardType = cardType
    }
    
    enum CodingKeys: String, CodingKey {
        case cardNumber = "card_number"
        case cardType = "card_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cardNumber = try container.decodeIfPresent(String.self, forKey: .cardNumber)
        self.cardType = try container.decodeIfPresent(String.self, forKey: .cardType)
    }
}
