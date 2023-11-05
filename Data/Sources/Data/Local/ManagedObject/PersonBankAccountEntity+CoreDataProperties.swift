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

    @NSManaged public var note: String?
    @NSManaged public var lastTransfer: Date?
    @NSManaged public var dateSaved: Date?
    @NSManaged var person: PersonDTO?
    @NSManaged var card: CardDTO?
    @NSManaged var more_info: CardTransferCountDTO?

}

extension PersonBankAccountEntity: Identifiable {}

extension PersonBankAccountEntity {

    static var sortDescriptor: NSSortDescriptor {
        NSSortDescriptor(key: #keyPath(PersonBankAccountEntity.dateSaved), ascending: false)
    }
}
