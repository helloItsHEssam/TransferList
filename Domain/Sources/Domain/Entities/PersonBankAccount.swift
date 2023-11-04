//
//  PersonBankAccount.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation

public struct PersonBankAccount: Identifiable {
    
    public var id: String {
        card?.cardNumber ?? UUID().uuidString
    }
    public var person: Person?
    public var card: Card?
    public var cardTransferCount: CardTransferCount?
    public var note: String?
    public var lastDateTransfer: Date?
}
