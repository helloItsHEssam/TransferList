//
//  HomeCollectionViewDataSource.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Domain

class HomeCollectionViewDataSource {
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<HomeItem.Section, HomeItem>
    private typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<HomeItem.Section, HomeItem>
    typealias UISection = HomeItem.UISection
    
    private var dataSource: DiffableDataSource!
    private var collectionView: BaseCollectionView
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(collectionView: BaseCollectionView) {
        self.collectionView = collectionView
        
        configureCollectionView()
        configureDiffableDataSource()
    }
    
    private func configureCollectionView() {
        collectionView.registerReusableCell(type: LargeHeaderCell.self)
        collectionView.registerReusableCell(type: VerticalAccountCell.self)
        collectionView.registerReusableCell(type: FavoriteAccountCell.self)
    }

    private func configureDiffableDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { [weak self] _, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .header(let title):
                return self?.createTitleCell(for: indexPath, title: title)
            case .personBankAccount(let account),
                    .favoriteBankAccount(let account):
                return self?.createAccountCell(for: indexPath, account: account)
            }
        })

        self.dataSource.supplementaryViewProvider = collectionView.makeSeprator()
    }
    
    private func createTitleCell(for indexPath: IndexPath, title: String) -> LargeHeaderCell {
        let cell: LargeHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setTitle(title)
        return cell
    }
    
    private func createAccountCell(for indexPath: IndexPath, account: PersonBankAccount) -> AccountCell {
        let section = sectionIdentifier(atSection: indexPath.section)
        if section == .favoriteBankAcconts {
            let cell: FavoriteAccountCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setAccountItem(account)
            return cell
            
        } else {
            let cell: VerticalAccountCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setAccountItem(account)
            return cell
        }
    }
    
    public func updateList(_ dataTransfer: DataTransfer<PersonBankAccount>) {
        semaphore.wait()
        
        var snapshot: DiffableSnapshot!
        switch dataTransfer.section {
        case .personBankAccounts: snapshot = self.updateAllSection(dataTransfer)
        case .favoriteBankAcconts: snapshot = self.updateFavoriteSection(dataTransfer)
        default: break
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
        
        self.semaphore.signal()
    }
    
    private func updateFavoriteSection(_ dataTransfer: DataTransfer<PersonBankAccount>) -> DiffableSnapshot {
        var snapshot = dataSource.snapshot()
        
        guard !dataTransfer.list.isEmpty else { return snapshot }
        let items = dataTransfer.list.map {
            return HomeItem.favoriteBankAccount(account: $0)
        }
        
        let newSections = [.FavoritesTitle, dataTransfer.section]
        let firstSection = snapshot.sectionIdentifiers.first
        if snapshot.sectionIdentifiers.isEmpty {
            snapshot.appendSections(newSections)
            snapshot.appendItems([.header(title: "Favorite")], toSection: .FavoritesTitle)
            
        } else {
            if !snapshot.sectionIdentifiers.contains(.FavoritesTitle) {
                snapshot.insertSections(newSections, beforeSection: firstSection!)
                snapshot.appendItems([.header(title: "Favorite")], toSection: .FavoritesTitle)
            }
        }
        
        snapshot.appendItems(items, toSection: dataTransfer.section)
        
        return snapshot
    }
    
    private func updateAllSection(_ dataTransfer: DataTransfer<PersonBankAccount>) -> DiffableSnapshot {
        let items = dataTransfer.list.map {
            return HomeItem.personBankAccount(account: $0)
        }

        var snapshot = dataSource.snapshot()
        if snapshot.sectionIdentifiers.contains(dataTransfer.section) {
            if dataTransfer.mode == .append {
                snapshot.appendItems(items, toSection: dataTransfer.section)
            } else {
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: dataTransfer.section))
                snapshot.appendItems(items, toSection: dataTransfer.section)
            }
        } else {
            
            if !snapshot.sectionIdentifiers.contains(.allTitle) {
                snapshot.appendSections([.allTitle])
                snapshot.appendItems([.header(title: "All")], toSection: .allTitle)
            }
            
            snapshot.appendSections([dataTransfer.section])
            snapshot.appendItems(items, toSection: dataTransfer.section)
        }

        return snapshot
    }
    
    public func sectionIdentifier(atSection section: Int) -> HomeItem.Section? {
        let sections = dataSource.snapshot().sectionIdentifiers
        guard sections.indices.contains(section) else { return nil }
        return dataSource.snapshot().sectionIdentifiers[section]
    }
    
    public func getAccount(at indexPath: IndexPath) -> PersonBankAccount? {
        guard let homeItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }

        switch homeItem {
        case .favoriteBankAccount(let account),
                .personBankAccount(let account):
            return account
            
        default: return nil
        }
    }
    
    public func updateAccountToFavorites(account: PersonBankAccount) {
        var accountNeedsToRemove = account
        var snapshot = updateFavoriteSection(.init(list: [account],
                                        mode: .append,
                                        section: .favoriteBankAcconts))
        
        // all
        accountNeedsToRemove.update(favoriteStatus: false)
        let itemNeedsToRemove = HomeItem.personBankAccount(account: accountNeedsToRemove)
        let item = HomeItem.personBankAccount(account: account)
        snapshot.insertItems([item], beforeItem: itemNeedsToRemove)
        snapshot.deleteItems([itemNeedsToRemove])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    public func removeAccountfromFavorites(account: PersonBankAccount) {
        var fakeAccount = account
        var snapshot = dataSource.snapshot()
        fakeAccount.update(favoriteStatus: true)
        
        let favItem = HomeItem.favoriteBankAccount(account: fakeAccount)
        let fakeItem = HomeItem.personBankAccount(account: fakeAccount)
        
        let item = HomeItem.personBankAccount(account: account)
        snapshot.insertItems([item], beforeItem: fakeItem)
        snapshot.deleteItems([fakeItem, favItem])
        
        if snapshot.itemIdentifiers(inSection: .favoriteBankAcconts).isEmpty {
            snapshot.deleteSections([.FavoritesTitle, .favoriteBankAcconts])
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
