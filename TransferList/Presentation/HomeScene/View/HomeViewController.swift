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

    private var dataSource: HomeCollectionViewDataSource!
    private let viewModel = ViewModelFactory.shared.createMediaViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func setupViews() {
        super.setupViews()

        configureDataSource()
        observeDidChangeData()        
        viewModel.fetchTransferList()
    }
    
    override var spaceSeparatorFromEdgeInList: CGFloat { return 0 }
    
    private func configureDataSource() {
        dataSource = .init(collectionView: collectionView)
    }
    
    private func observeDidChangeData() {
        viewModel.$bankAccounts
            .sink { [weak self] accounts in
                self?.dataSource?.updateAccounts(accounts)
            }
            .store(in: &subscriptions)
    }
}
