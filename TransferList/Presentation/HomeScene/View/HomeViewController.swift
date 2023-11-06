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

        collectionView.delegate = self
        configureRefresher()
        configureDataSource()
        observeDidChangeData()        
        viewModel.fetchTransferList()
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
