//
//  HomeItem.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation

enum HomeItem: Hashable {
    typealias UISection = (section: HomeItem.Section, items: [HomeItem])

    enum Section: CaseIterable {
        case FavoritesTitle
    }

    case header(title: String)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .header(let title): hasher.combine(title)
        }
    }

    static func == (lhs: HomeItem, rhs: HomeItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
