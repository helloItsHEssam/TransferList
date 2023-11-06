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
    private(set) var listHolder: [T] = []
        
    init(list: [T], mode: Mode, section: HomeItem.Section) {
        self.list = list
        self.mode = mode
        self.section = section
        self.listHolder = list
    }
    
    mutating func append(contentsOf items: [T]) {
        if mode == .append {
            listHolder.append(contentsOf: items)
        } else {
            listHolder = items
        }

        list = items
    }
    
    mutating func append(item: T) {
        if mode == .append {
            listHolder.append(item)
        } else {
            listHolder = [item]
        }

        list = [item]
    }
    
    func isLastItem(row: Int) -> Bool {
        return listHolder.count - 1 == row
    }
}
