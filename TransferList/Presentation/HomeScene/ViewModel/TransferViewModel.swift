//
//  TransferViewModel.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation
import Combine
import Domain

class TransferViewModel {
    
    @Published var viewState: ViewState!
    var dataUpdated = PassthroughSubject<DataTransfer<PersonBankAccount>, Never>()
    var errorForSavingOrRemoving = PassthroughSubject<ViewState, Never>()
    var changeView = PassthroughSubject<Router, Never>()
    var favoriteStatusUpdated = PassthroughSubject<PersonBankAccount, Never>()
    private let useCase: PersonBankAccountUseCase
    private var subscriptions = Set<AnyCancellable>()
    private var paginationMode = PaginationMode()
    private var dataFromServer: DataTransfer<PersonBankAccount>!
    private var dataFromLocal: DataTransfer<PersonBankAccount>!
    
    deinit {
        cancelAllPendingTask()
    }
    
    init(personBackAccountUseCase: PersonBankAccountUseCase) {
        useCase = personBackAccountUseCase
    }
    
    private func cancelAllPendingTask() {
        subscriptions.removeAll()
    }
    
    private func updateViewState(newState viewState: ViewState) {
        self.viewState = viewState
    }
    
    private func updateAccounts(appendAccounts accounts: [PersonBankAccount]) {
        guard !accounts.isEmpty else {
            paginationMode.mode = .reachedToEnd
            return
        }

        if dataFromServer == nil {
            dataFromServer = .init(list: accounts, mode: .initial, section: .personBankAccounts)
        } else {
            dataFromServer.append(contentsOf: accounts)
        }
        
        dataUpdated.send(dataFromServer)
    }
    
    public func fetchFavoriteList() {
        useCase.fetchFavoritePersonAccounts()
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] accounts in
                guard let self else { return }
                self.dataFromLocal = .init(list: accounts,
                                           mode: .initial,
                                           section: .favoriteBankAcconts)
                self.dataUpdated.send(self.dataFromLocal)
            })
            .store(in: &subscriptions)
    }
    
    public func fetchTransferList() {
        updateViewState(newState: .loading)
        
        useCase.fetchPersonAccounts(withOffest: paginationMode.nextOffset)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished: break
                    
                case .failure(let error):
                    self.updateViewState(newState: .error(message: error.errorDescription ?? "Unexpected error"))
                    break
                }
                
            } receiveValue: { [weak self] accounts in
                guard let self else { return }
                self.updateAccounts(appendAccounts: accounts)
                self.paginationMode.moveToNextOffset()
                self.updateViewState(newState: .result)
            }
            .store(in: &subscriptions)
    }
    
    public func refreshData() {
        guard viewState != .loading else { return }
        
        paginationMode.reset()
        dataFromServer?.mode = .initial
        fetchTransferList()
    }
    
    public func itemDisplay(atSection section: HomeItem.Section, row: Int) {
        guard viewState != .loading else { return }
        guard section == .personBankAccounts else { return }
        guard paginationMode.mode == .continues else { return }
        guard dataFromServer.isLastItem(row: row) else { return }
        
        dataFromServer?.mode = .append
        
        fetchTransferList()
    }
    
    public func accountSelected(_ account: PersonBankAccount) {
        changeView.send(.detail(account: account))
    }
    
    public func removeFromFavorite(account: PersonBankAccount) {
        useCase.removePersonAccountFromFavorites(account)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished: break
                case .failure(let error):
                    let viewError = ViewState.error(message: error.errorDescription ?? "Unexpected error")
                    self.errorForSavingOrRemoving.send(viewError)
                    break
                }
                
            } receiveValue: { [weak self] account in
                self?.favoriteStatusUpdated.send(account)
            }.store(in: &subscriptions)
    }
    
    public func saveToFavorite(account: PersonBankAccount) {
        useCase.savePersonAccountToFavorites(account)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished: break
                case .failure(let error):
                    let viewError = ViewState.error(message: error.errorDescription ?? "Unexpected error")
                    self.errorForSavingOrRemoving.send(viewError)
                    break
                }
                
            } receiveValue: { [weak self] account in
                self?.favoriteStatusUpdated.send(account)
            }.store(in: &subscriptions)
    }
}
