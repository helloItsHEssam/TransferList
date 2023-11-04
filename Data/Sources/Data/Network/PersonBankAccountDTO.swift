//
//  PersonBankAccountDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

public struct PersonBankAccountDTO: Decodable {
    
    var person: PersonDTO?
    var card: CardDTO?
    var more_info: CardTransferCountDTO?
    var note: String?
    var last_transfer: Date?
}
