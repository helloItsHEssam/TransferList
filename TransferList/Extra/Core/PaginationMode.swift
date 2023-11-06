//
//  PaginationMode.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation

struct PaginationMode {
    
    enum Mode {
        case continues
        case reachedToEnd
    }
    
    var offset: Int = 0
    var mode: Mode = .continues
    
    var nextOffset: Int {
        offset + 1
    }
    
    mutating func moveToNextOffset() {
        self.offset += 1
    }
    
    mutating func reset() {
        offset = 0
        mode = .continues
    }
}
