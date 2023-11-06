//
//  HomeViewController.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Combine

class HomeViewController: BaseCollectionViewController {

    @InstantiateView(type: UIRefreshControl.self) private var refresher
    private var dataSource: HomeCollectionViewDataSource!
    private let viewModel = ViewModelFactory.shared.createMediaViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func setupViews() {
        super.setupViews()

        collectionView.contentInset.top = 32
        collectionView.delegate = self
        configureRefresher()
        configureDataSource()
        observeDidChangeData()        
        viewModel.fetchTransferList()
        viewModel.fetchFavoriteList()
    }
    
    override var spaceSeparatorFromEdgeInList: CGFloat { return 0 }
    
    private func configureRefresher() {
        collectionView.alwaysBounceVertical = true
        refresher.tintColor = Theme.supplementaryBackground
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refresher)
    }
    
    @objc func refreshData() {
        self.refresher.beginRefreshing()
        
        viewModel.refreshData()
    }
    
    private func configureDataSource() {
        dataSource = .init(collectionView: collectionView)
    }
    
    private func observeDidChangeData() {
        viewModel.$dataUpdated
            .compactMap { $0 }
            .sink { [weak self] data in
                self?.refresher.endRefreshing()
                self?.dataSource.updateData(data)
            }
            .store(in: &subscriptions)
    }

    func createCustomSection(at section: Int) -> NSCollectionLayoutSection? {
        guard dataSource.sectionIdentifier(atSection: section) == .favoriteBankAcconts else {
            return nil
        }

        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80),
                                              heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(18), top: nil, trailing: nil, bottom: nil)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let section = dataSource.sectionIdentifier(atIndexPath: indexPath) else {
            return
        }
        viewModel.itemDisplay(atSection: section, row: indexPath.row)
    }
}
