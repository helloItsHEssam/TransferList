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
    }

    private func configureDiffableDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { [weak self] _, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .information(let title, let value):
                return self?.createValueCell(for: indexPath, title: title, value: value)
            case .header(let title):
                return self?.createHeaderCell(for: indexPath, title: title)
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
    
    public func showInformation(_ cardInformation: CardTransferCount?) {
        var initialSnapshot = dataSource.snapshot()
        
        initialSnapshot.appendSections([.title, .information])
        let header = DetailItem.header(title: "More information")
        initialSnapshot.appendItems([header], toSection: .title)
        
        let total = DetailItem.information(title: "Total transfer",
                                                   value: cardInformation?.totalTransfer ?? 0)
        let numberOfTrans = DetailItem.information(title: "Number of transfers",
                                                   value: cardInformation?.numberOfTransfers ?? 0)
        initialSnapshot.appendItems([total, numberOfTrans], toSection: .information)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
}
