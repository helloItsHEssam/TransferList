//
//  CardTransferCountMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Domain

struct CardTransferCountMapper: Mapper {
    
    typealias Entity = CardTransferCount?
    typealias Dto = CardTransferCountDTO?
    
    func mapDtoToEntity(input: CardTransferCountDTO?) -> CardTransferCount? {
        guard let input else { return nil }
        return .init(numberOfTransfers: input.number_of_transfers,
                     totalTransfer: input.total_transfer)
    }
    
    func mapEntityToDto(input: CardTransferCount?) -> CardTransferCountDTO? {
        guard let input else { return nil }
        return .init(number_of_transfers: input.numberOfTransfers,
                     total_transfer: input.totalTransfer)
    }
}
