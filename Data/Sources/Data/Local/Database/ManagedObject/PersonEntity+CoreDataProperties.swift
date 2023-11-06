//
//  PersonEntity+CoreDataProperties.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//
//

import Foundation
import CoreData

extension PersonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonEntity> {
        return NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
    }

    @NSManaged var avatar: String?
    @NSManaged var email: String?
    @NSManaged var name: String?
    @NSManaged var account: PersonBankAccountEntity?

}
