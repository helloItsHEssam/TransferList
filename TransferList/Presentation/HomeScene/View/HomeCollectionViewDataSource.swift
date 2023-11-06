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
    
    init(collectionView: BaseCollectionView) {
        self.collectionView = collectionView
        
        configureCollectionView()
        configureDiffableDataSource()
    }
    
    private func configureCollectionView() {
        collectionView.registerReusableCell(type: LargeHeaderCell.self)
        collectionView.registerReusableCell(type: VerticalAccountCell.self)        
    }

    private func configureDiffableDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { [weak self] _, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .header(let title):
                return self?.createTitleCell(for: indexPath, title: title)
            case .personBankAccount(let account):
                return self?.createVerticalAccount(for: indexPath, account: account)
            }
        })

        self.dataSource.supplementaryViewProvider = collectionView.makeSeprator()
    }
    
    private func createTitleCell(for indexPath: IndexPath, title: String) -> LargeHeaderCell {
        let cell: LargeHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setTitle(title)
        return cell
    }
    
    private func createVerticalAccount(for indexPath: IndexPath, account: PersonBankAccount) -> VerticalAccountCell {
        let cell: VerticalAccountCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setAccountItem(account)
        return cell
    }
    
    public func updateData(_ dataTransfer: DataTransfer<PersonBankAccount>) {
        switch dataTransfer.section {
        case .personBankAccounts: updateAllSection(dataTransfer)
            
        default: break
        }
    }
    
    private func updateAllSection(_ dataTransfer: DataTransfer<PersonBankAccount>) {
        let items = dataTransfer.list.map {
            return HomeItem.personBankAccount(account: $0)
        }
        
        var snapShot = dataSource.snapshot()
        if snapShot.sectionIdentifiers.contains(dataTransfer.section) {
            if dataTransfer.mode == .append {
                snapShot.appendItems(items, toSection: dataTransfer.section)
            } else {
                snapShot.deleteItems(snapShot.itemIdentifiers(inSection: dataTransfer.section))
                snapShot.appendItems(items, toSection: dataTransfer.section)
            }
        } else {
            
            if !snapShot.sectionIdentifiers.contains(.allTitle) {
                snapShot.appendSections([.allTitle])
                snapShot.appendItems([.header(title: "All")], toSection: .allTitle)
            }
            
            snapShot.appendSections([dataTransfer.section])
            snapShot.appendItems(items, toSection: dataTransfer.section)
        }
        
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    public func sectionIdentifier(atIndexPath indexPath: IndexPath) -> HomeItem.Section? {
        if #available(iOS 15.0, *) {
            return dataSource.sectionIdentifier(for: indexPath.section)
        } else {
            guard let item = dataSource.itemIdentifier(for: indexPath) else {
                return nil
            }
            return dataSource.snapshot().sectionIdentifier(containingItem: item)
        }
    }

//    private func prepareToDecideShowTopicRowsBasedOn(topicCount count: Int, into snapShot: inout DiffableSnapshot) {
//        let isContainTopicItems = snapShot.itemIdentifiers.contains(.topicsHeader)
//        if count == 0 && isContainTopicItems {
//            snapShot.deleteSections([.topicsHeader, .topics])
//        }
//    }
//
//    private func checkDeleteSearchOrTopicsBasedOnDeleteTopic(saveChangeIntoSnapShot snapShot: inout DiffableSnapshot) {
//        if snapShot.itemIdentifiers(inSection: .topics).isEmpty {
//            snapShot.deleteSections([.search, .topics, .topicsHeader])
//        }
//    }

//    func loadTopicCount(count: Int) {
//        var snapShot = dataSource.snapshot()
//        languageItem.topicCount = count
//        snapShot.reloadItems([.topicCount])
//
//        prepareToDecideShowTopicRowsBasedOn(topicCount: count, into: &snapShot)
//        dataSource.apply(snapShot, animatingDifferences: true)
//    }

//    func loadFirstTimeTopics(topics items: [Topic]) {
//        var snapShot = dataSource.snapshot()
//        if !snapShot.sectionIdentifiers.contains(.topicsHeader) {
//            snapShot.insertSections([.search, .topicsHeader, .topics], beforeSection: .overviewHeader)
//            snapShot.appendItems([.topicsHeader], toSection: .topicsHeader)
//            snapShot.appendItems([.search], toSection: .search)
//        } else {
//            // remove all topics and load with new sort
//            snapShot.deleteItems(snapShot.itemIdentifiers(inSection: .topics))
//        }
//
//        let topicItems = items.map { DetailLanguage.topics(item: $0) }
//        snapShot.appendItems(topicItems, toSection: .topics)
//
//        dataSource.apply(snapShot, animatingDifferences: true)
//    }


//    func getTopic(at indexPath: IndexPath) -> Topic {
//        guard let languageItem = dataSource.itemIdentifier(for: indexPath) else {
//            return Topic.createEmptyTopic()
//        }
//
//        guard case let .topics(item) = languageItem else {
//            return Topic.createEmptyTopic()
//        }
//
//        return item
//    }

//    func deleteTopics(topics items: [Topic]) {
//        var snapshot = dataSource.snapshot()
//        let items = items.map { DetailLanguage.topics(item: $0) }
//        snapshot.deleteItems(items)
//
//        checkDeleteSearchOrTopicsBasedOnDeleteTopic(saveChangeIntoSnapShot: &snapshot)
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }

//    func updateTopic(topic item: Topic) {
//        var snapshot = dataSource.snapshot()
//        let item = DetailLanguage.topics(item: item)
//        snapshot.reloadItems([item])
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
}
