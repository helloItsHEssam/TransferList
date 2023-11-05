//
//  PersonDTOTransformer.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

@objc(PersonDTOTransformer)
class PersonDTOTransformer: NSSecureUnarchiveFromDataTransformer {
    
    override class var allowedTopLevelClasses: [AnyClass] {
        return [PersonDTO.self]
    }

    static func register() {
        let className = String(describing: PersonDTOTransformer.self)
        let name = NSValueTransformerName(className)

        let transformer = PersonDTOTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
