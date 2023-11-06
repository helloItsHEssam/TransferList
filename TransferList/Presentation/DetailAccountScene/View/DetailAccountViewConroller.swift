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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func updateConfiguration(_ configuration: Configuration) {
        self.account = configuration.account
        self.viewModel = configuration.viewModel
    }
    
    override var spaceSeparatorFromEdgeInList: CGFloat { return 12 }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.contentInset.top = 32
    }
    
    private func configureDataSource() {
        dataSource = .init(collectionView: collectionView)
    }
    
    private func observeDidChangeData() {
        viewModel.$viewState
            .compactMap { $0 }
            .drop(while: {
                $0 == .loading || $0 == .result
            })
            .compactMap { String(describing: $0) }
            .sink { [weak self] errorMessage in
                guard let self else { return }
                print(errorMessage)
            }
            .store(in: &subscriptions)
        
        viewModel.favoriteStatusUpdated
            .sink { [weak self] account in
                self?.account = account
                self?.dataSource.updateFavoriteStatus(isFavorite: account.isFavorite)
            }.store(in: &subscriptions)
    }
    
    private func showInformation() {
        dataSource.showInformation(account)
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

extension DetailAccountViewConroller: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case let .addRemoveFavorite(isFavorite) = dataSource.getItem(at: indexPath) else {
            return
        }
        
        if isFavorite {
            viewModel.removeFromFavorite(account: account)

        } else {
            viewModel.saveToFavorite(account: account)
        }
    }
}
