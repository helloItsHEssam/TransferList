//
//  HomeCollectionViewDataSource.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI

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
    }

    private func configureDiffableDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { [weak self] _, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .header(let title):
                return self?.createTitleCell(for: indexPath, title: title)
            }
        })

        self.dataSource.supplementaryViewProvider = collectionView.makeSeprator()
    }
    
    private func createTitleCell(for indexPath: IndexPath, title: String) -> LargeHeaderCell {
        let cell: LargeHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setTitle(title)
        return cell
    }
    
    public func LoadTitle(message: String) {
        var snapShot = dataSource.snapshot()
        snapShot.appendSections([.FavoritesTitle])
        snapShot.appendItems([.header(title: message)], toSection: .FavoritesTitle)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
//    private func initDataSource(_ items: [UISection]) {
//        var initialSnapshot = DiffableSnapshot()
//        let sections = items.map { $0.section }
//        initialSnapshot.appendSections(sections)
//
//        for item in items {
//            initialSnapshot.appendItems(item.items, toSection: item.section)
//        }
//        self.dataSource.apply(initialSnapshot, animatingDifferences: true)
//    }

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
