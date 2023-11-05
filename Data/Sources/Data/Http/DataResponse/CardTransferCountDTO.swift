//
//  CardTransferCountDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

class CardTransferCountDTO: NSObject, NSSecureCoding, Decodable {
    
    static var supportsSecureCoding: Bool = true
    var numberOfTransfers: Int?
    var totalTransfer: Int?
    
    init(numberOfTransfers: Int? = nil, totalTransfer: Int? = nil) {
        self.numberOfTransfers = numberOfTransfers
        self.totalTransfer = totalTransfer
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(numberOfTransfers, forKey: CodingKeys.numberOfTransfers.rawValue)
        coder.encode(totalTransfer, forKey: CodingKeys.totalTransfer.rawValue)
    }

    enum CodingKeys: String, CodingKey {
        case numberOfTransfers = "number_of_transfers"
        case totalTransfer = "total_transfer"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.numberOfTransfers = try container.decodeIfPresent(Int.self, forKey: .numberOfTransfers)
        self.totalTransfer = try container.decodeIfPresent(Int.self, forKey: .totalTransfer)
    }
    
    required convenience init?(coder: NSCoder) {
        let numberOfTransfers = coder.decodeObject(of: NSNumber.self,
                                                     forKey: CodingKeys.numberOfTransfers.rawValue)?.intValue
        let totalTransfer = coder.decodeObject(of: NSNumber.self,
                                                forKey: CodingKeys.totalTransfer.rawValue)?.intValue

        self.init(numberOfTransfers: numberOfTransfers, totalTransfer: totalTransfer)
    }
}
