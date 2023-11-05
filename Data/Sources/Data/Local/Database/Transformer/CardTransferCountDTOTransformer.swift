//
//  CardTransferCountDTOTransformer.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

@objc(CardTransferCountDTOTransformer)
class CardTransferCountDTOTransformer: NSSecureUnarchiveFromDataTransformer {
    
    override class var allowedTopLevelClasses: [AnyClass] {
        return [CardTransferCountDTO.self]
    }

    static func register() {
        let className = String(describing: CardTransferCountDTOTransformer.self)
        let name = NSValueTransformerName(className)

        let transformer = CardTransferCountDTOTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
