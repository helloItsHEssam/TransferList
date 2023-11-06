//
//  DetailAccountDataSource.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Domain

class DetailAccountDataSource {
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<DetailItem.Section, DetailItem>
    private typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<DetailItem.Section, DetailItem>
    typealias UISection = DetailItem.UISection
    
    private var dataSource: DiffableDataSource!
    private var collectionView: BaseCollectionView
    
    init(collectionView: BaseCollectionView) {
        self.collectionView = collectionView
        
        configureCollectionView()
        configureDiffableDataSource()
    }
    
    private func configureCollectionView() {
        collectionView.registerReusableCell(type: TitleValueCell.self)
        collectionView.registerReusableCell(type: HeaderInformationCell.self)
        collectionView.registerReusableCell(type: AddRemoveFavoriteCell.self)
    }

    private func configureDiffableDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { [weak self] _, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .information(let title, let value):
                return self?.createValueCell(for: indexPath, title: title, value: value)
            case .header(let title):
                return self?.createHeaderCell(for: indexPath, title: title)
            case .addRemoveFavorite(let isFavorite):
                return self?.createAddRemoveFavorite(for: indexPath, isFavorite: isFavorite)
            }
        })

        self.dataSource.supplementaryViewProvider = collectionView.makeSeprator()
    }
    
    private func createHeaderCell(for indexPath: IndexPath, title: String) -> HeaderInformationCell {
        let cell: HeaderInformationCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setTitle(title)
        return cell
    }
    
    private func createValueCell(for indexPath: IndexPath, title: String, value: Int) -> TitleValueCell {
        let cell: TitleValueCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(title: title, value: value)
        return cell
    }
    
    private func createAddRemoveFavorite(for indexPath: IndexPath,
                                         isFavorite: Bool) -> AddRemoveFavoriteCell {
        let cell: AddRemoveFavoriteCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setFavoriteStatus(isFavorite: isFavorite)
        return cell
    }
    
    public func showInformation(_ account: PersonBankAccount) {
        var initialSnapshot = dataSource.snapshot()
        
        initialSnapshot.appendSections([.title, .information])
        let header = DetailItem.header(title: "More information")
        initialSnapshot.appendItems([header], toSection: .title)
        
        let cardInformation = account.cardTransferCount
        let total = DetailItem.information(title: "Total transfer",
                                                   value: cardInformation?.totalTransfer ?? 0)
        let numberOfTrans = DetailItem.information(title: "Number of transfers",
                                                   value: cardInformation?.numberOfTransfers ?? 0)
        let addRemove = DetailItem.addRemoveFavorite(isFavorite: account.isFavorite)
        
        initialSnapshot.appendItems([total, numberOfTrans, addRemove], toSection: .information)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    public func updateFavoriteStatus(isFavorite: Bool) {
        let indexPath = IndexPath(row: 2, section: 1)
        guard let oldItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let addRemove = DetailItem.addRemoveFavorite(isFavorite: isFavorite)
        
        var newSnapShot = dataSource.snapshot()
        newSnapShot.deleteItems([oldItem])
        newSnapShot.appendItems([addRemove], toSection: .information)
        
        dataSource.apply(newSnapShot, animatingDifferences: true)
    }
    
    public func getItem(at indexPath: IndexPath) -> DetailItem? {
        guard let detailItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        return detailItem
    }
}
