//
//  HomeItem.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation
import Domain

enum HomeItem: Hashable {
    typealias UISection = (section: HomeItem.Section, items: [HomeItem])

    enum Section: CaseIterable {
        case FavoritesTitle
        case favoriteBankAcconts
        case allTitle
        case personBankAccounts
    }

    case header(title: String)
    case favoriteBankAccount(account: PersonBankAccount)
    case personBankAccount(account: PersonBankAccount)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .header(let title): hasher.combine(title)
            
        case .favoriteBankAccount(let account):
            hasher.combine("favorite")
            hasher.combine(account)
            
        case .personBankAccount(let account):
            hasher.combine("accounts")
            hasher.combine(account)
            hasher.combine(account.isFavorite)
        }
    }

    static func == (lhs: HomeItem, rhs: HomeItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
