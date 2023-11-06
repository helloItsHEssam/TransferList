//
//  DetailAccountViewConroller.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Combine
import Domain

class DetailAccountViewConroller: BaseCollectionViewController {

    struct Configuration {
        var viewModel: TransferViewModel
        var account: PersonBankAccount
    }
    
    private var dataSource: DetailAccountDataSource!
    private var viewModel: TransferViewModel!
    private var account: PersonBankAccount!
    private var subscriptions = Set<AnyCancellable>()
    
    override func setupViews() {
        super.setupViews()
        
        configureCollectionView()
        configureDataSource()
        observeDidChangeData()
        showInformation()
    }
    
    func updateConfiguration(_ configuration: Configuration) {
        self.account = configuration.account
        self.viewModel = configuration.viewModel
    }
    
    override var spaceSeparatorFromEdgeInList: CGFloat { return 12 }
    
    private func configureCollectionView() {
        collectionView.contentInset.top = 32
    }
    
    private func configureDataSource() {
        dataSource = .init(collectionView: collectionView)
    }
    
    private func observeDidChangeData() {
//        viewModel.$dataUpdated
//            .compactMap { $0 }
//            .sink { [weak self] data in
//                self?.refresher.endRefreshing()
//                self?.dataSource.updateData(data)
//            }
//            .store(in: &subscriptions)
    }
    
    private func showInformation() {
        dataSource.showInformation(account.cardTransferCount)
    }
    
    func isNeedBorder(at section: Int) -> Bool {
        return section == 0 ? false : true
    }
    
    func contentInsets(at section: Int, currentConfig: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
        var editConfig = currentConfig
        if section == 0 {
            editConfig.bottom = -12
        }

        return editConfig
    }
}
