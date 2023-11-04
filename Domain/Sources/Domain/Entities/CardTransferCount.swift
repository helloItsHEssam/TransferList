//
//  CardTransferCount.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Foundation

public struct CardTransferCount {
    
    public var numberOfTransfers: Int?
    public var totalTransfer: Int?
    
    public init(numberOfTransfers: Int?, totalTransfer: Int?) {
        self.numberOfTransfers = numberOfTransfers
        self.totalTransfer = totalTransfer
    }
}
