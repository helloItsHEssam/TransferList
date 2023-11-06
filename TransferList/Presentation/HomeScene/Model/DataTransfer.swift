//
//  DataTransfer.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation
import Domain

struct DataTransfer<T> {
    
    enum Mode {
        case initial
        case append
    }
    
    var list: [T]
    var mode: Mode
    var section: HomeItem.Section
    
    mutating func append(contentsOf items: [T]) {
        if mode == .append {
            list.append(contentsOf: items)
        } else {
            list = items
        }
    }
}
