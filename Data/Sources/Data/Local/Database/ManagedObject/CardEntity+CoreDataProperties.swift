//
//  CardEntity+CoreDataProperties.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//
//

import Foundation
import CoreData

extension CardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardEntity> {
        return NSFetchRequest<CardEntity>(entityName: "CardEntity")
    }

    @NSManaged var cardNumber: String?
    @NSManaged var cardType: String?
    @NSManaged var account: PersonBankAccountEntity?

}
