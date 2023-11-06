//
//  HomeViewController.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Combine
import Domain

class HomeViewController: BaseCollectionViewController {

    @InstantiateView(type: UIRefreshControl.self) private var refresher
    private var dataSource: HomeCollectionViewDataSource!
    private let viewModel = ViewModelFactory.shared.createMediaViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func setupViews() {
        super.setupViews()
        
        configureCollectionView()
        configureRefresher()
        configureDataSource()
        observeDidChangeData()        
        viewModel.fetchTransferList()
        viewModel.fetchFavoriteList()
    }
    
    override var spaceSeparatorFromEdgeInList: CGFloat { return 0 }
    
    private func configureCollectionView() {
        collectionView.contentInset.top = 32
        collectionView.delegate = self
    }
    
    private func configureRefresher() {
        refresher.tintColor = Theme.supplementaryBackground
        refresher.addTarget(self, action: #selector(beginRefreshing), for: .valueChanged)
        collectionView.addSubview(refresher)
    }
    
    @objc private func beginRefreshing() {
        self.refresher.beginRefreshing()
        
        viewModel.refreshList()
    }
    
    private func configureDataSource() {
        dataSource = .init(collectionView: collectionView)
    }
    
    private func observeDidChangeData() {
        viewModel.accountsNeedToShow
            .sink { [weak self] accounts in
                self?.refresher.endRefreshing()
                self?.dataSource.updateList(accounts)
            }
            .store(in: &subscriptions)
        
        viewModel.router
            .compactMap { $0 }
            .sink { [weak self] route in
                guard case let .detail(account) = route else {
                    return
                }
                self?.navigateToDetailViewController(withAccount: account)
            }
            .store(in: &subscriptions)
        
        viewModel.favoriteStatusUpdated
            .share()
            .filter { $0.isFavorite }
            .sink { [weak self] account in
                self?.dataSource.updateAccountToFavorites(account: account)
            }.store(in: &subscriptions)
        
        viewModel.favoriteStatusUpdated
            .share()
            .filter { !$0.isFavorite }
            .sink { [weak self] account in
                self?.dataSource.removeAccountfromFavorites(account: account)
            }.store(in: &subscriptions)
        
        viewModel.$viewState
            .compactMap { $0 }
            .drop(while: {
                $0 == .loading || $0 == .result
            })
            .compactMap { String(describing: $0) }
            .sink { [weak self] errorMessage in
                guard let self else { return }
                self.showAlert(title: "Error", message: errorMessage)
            }
            .store(in: &subscriptions)
    }
    
    private func navigateToDetailViewController(withAccount account: PersonBankAccount) {
        let detailViewController = DetailAccountViewConroller()
        detailViewController.updateConfiguration(.init(viewModel: viewModel,
                                                       account: account))
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func createCustomSection(at section: Int) -> NSCollectionLayoutSection? {
        guard dataSource.sectionIdentifier(atSection: section) == .favoriteBankAcconts else {
            return nil
        }

        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80),
                                              heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(10), top: nil, trailing: nil, bottom: nil)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let account = dataSource.getAccount(at: indexPath) else {
            return
        }
        viewModel.accountSelected(account)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let section = dataSource.sectionIdentifier(atSection: indexPath.section) else {
            return
        }
        viewModel.reachedToRow(row: indexPath.row, atSection: section)
    }
}
