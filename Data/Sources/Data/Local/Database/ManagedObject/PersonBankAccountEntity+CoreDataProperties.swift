//
//  PersonBankAccountEntity+CoreDataProperties.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//
//

import Foundation
import CoreData

extension PersonBankAccountEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonBankAccountEntity> {
        return NSFetchRequest<PersonBankAccountEntity>(entityName: "PersonBankAccountEntity")
    }

    @NSManaged var dateSaved: Date?
    @NSManaged var lastTransfer: Date?
    @NSManaged var moreInfo: CardTransferCountDTO?
    @NSManaged var note: String?
    @NSManaged var isFavorite: Bool
    @NSManaged var card: CardEntity?
    @NSManaged var person: PersonEntity?
}

extension PersonBankAccountEntity {

    static var sortDescriptor: NSSortDescriptor {
        NSSortDescriptor(key: #keyPath(PersonBankAccountEntity.dateSaved), ascending: false)
    }
}
