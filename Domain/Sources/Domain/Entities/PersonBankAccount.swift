//
//  PersonBankAccount.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation

public struct PersonBankAccount: Identifiable, Hashable {

    public var id: String {
        card?.cardNumber ?? UUID().uuidString
    }
    public var person: Person?
    public var card: Card?
    public var cardTransferCount: CardTransferCount?
    public var note: String?
    public var lastDateTransfer: Date?
    public private(set) var isFavorite: Bool = false
    var indexAtList: Int = 0
    
    public init(person: Person?, card: Card?, cardTransferCount: CardTransferCount?,
         note: String?, lastDateTransfer: Date?) {
        self.person = person
        self.card = card
        self.cardTransferCount = cardTransferCount
        self.note = note
        self.lastDateTransfer = lastDateTransfer
    }
    
    public mutating func update(favoriteStatus isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    mutating func update(indexAtList index: Int) {
        self.indexAtList = index
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: PersonBankAccount, rhs: PersonBankAccount) -> Bool {
        lhs.id == rhs.id
    }
}
