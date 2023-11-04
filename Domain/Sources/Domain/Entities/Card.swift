//
//  Card.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation

public struct Card {
    
    public var cardNumber: String?
    public var cardType: String?
    
    public init(cardNumber: String?, cardType: String?) {
        self.cardNumber = cardNumber
        self.cardType = cardType
    }
}
