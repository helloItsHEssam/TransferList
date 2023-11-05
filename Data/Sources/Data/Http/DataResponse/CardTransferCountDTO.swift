//
//  CardTransferCountDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

class CardTransferCountDTO: NSObject, NSSecureCoding, Decodable {
    
    enum Key: String {
        case numberOfTransfers
        case totalTransfer
    }
    
    static var supportsSecureCoding: Bool = true
    var number_of_transfers: Int?
    var total_transfer: Int?
    
    init(number_of_transfers: Int? = nil, total_transfer: Int? = nil) {
        self.number_of_transfers = number_of_transfers
        self.total_transfer = total_transfer
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(number_of_transfers, forKey: Key.numberOfTransfers.rawValue)
        coder.encode(total_transfer, forKey: Key.totalTransfer.rawValue)
    }
    
    required convenience init?(coder: NSCoder) {
        let number_of_transfers = coder.decodeObject(of: NSNumber.self,
                                                     forKey: Key.numberOfTransfers.rawValue)?.intValue
        let total_transfer = coder.decodeObject(of: NSNumber.self,
                                                forKey: Key.totalTransfer.rawValue)?.intValue

        self.init(number_of_transfers: number_of_transfers, total_transfer: total_transfer)
    }
}
