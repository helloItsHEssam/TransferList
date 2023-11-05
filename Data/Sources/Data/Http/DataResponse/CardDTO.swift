//
//  CardDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

class CardDTO: NSObject, NSSecureCoding, Decodable {
    
    enum Key: String {
        case cardNumber
        case cardType
    }
    
    static var supportsSecureCoding: Bool = true
    var card_number: String?
    var card_type: String?
    
    init(card_number: String? = nil, card_type: String? = nil) {
        self.card_number = card_number
        self.card_type = card_type
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(card_number, forKey: Key.cardNumber.rawValue)
        coder.encode(card_type, forKey: Key.cardType.rawValue)
    }
    
    required convenience init?(coder: NSCoder) {
        let card_number = coder.decodeObject(of: NSString.self,
                                             forKey: Key.cardNumber.rawValue) as? String
        let card_type = coder.decodeObject(of: NSString.self,
                                           forKey: Key.cardType.rawValue) as? String

        self.init(card_number: card_number, card_type: card_type)
    }
}
