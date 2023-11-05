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
        return .init(numberOfTransfers: input.numberOfTransfers,
                     totalTransfer: input.totalTransfer)
    }
    
    func mapEntityToDto(input: CardTransferCount?) -> CardTransferCountDTO? {
        guard let input else { return nil }
        return .init(numberOfTransfers: input.numberOfTransfers,
                     totalTransfer: input.totalTransfer)
    }
}
