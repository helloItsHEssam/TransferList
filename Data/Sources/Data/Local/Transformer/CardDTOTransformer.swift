//
//  CardDTOTransformer.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

@objc(CardDTOTransformer)
class CardDTOTransformer: NSSecureUnarchiveFromDataTransformer {
    
    override class var allowedTopLevelClasses: [AnyClass] {
        return [CardDTO.self]
    }

    static func register() {
        let className = String(describing: CardDTOTransformer.self)
        let name = NSValueTransformerName(className)

        let transformer = CardDTOTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
