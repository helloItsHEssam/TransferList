//
//  DetailItem.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation
import Domain

enum DetailItem: Hashable {
    typealias UISection = (section: DetailItem.Section, items: [DetailItem])

    enum Section: CaseIterable {
        case title
        case information
    }

    case header(title: String)
    case information(title: String, value: Int)
    case addRemoveFavorite(isFavorite: Bool)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .header(let title): hasher.combine(title)
            
        case .information(let title, let value):
            hasher.combine(title)
            hasher.combine(value)
            
        case .addRemoveFavorite(let isFavorite):
            hasher.combine(isFavorite)
            hasher.combine("addRmoveFavorite")
        }
    }

    static func == (lhs: DetailItem, rhs: DetailItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
