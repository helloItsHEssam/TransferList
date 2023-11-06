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
    
    @Published var dataUpdated: DataTransfer<PersonBankAccount>!
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
    
//    private func updateViewState(newState viewState: ViewState) {
//        self.viewState = viewState
//    }
//
//    func selected(media: Media) {
//        path.append(NavigationRouter.DetailOfMedia(media: media))
//    }
    
    func fetchTransferList() {
        // update view state
        
        useCase.fetchPersonAccounts(withOffest: paginationMode.nextOffset)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished: break
                    
                case .failure(let error):
                    // show error
                    break
                }
                
            } receiveValue: { [weak self] accounts in
                guard let self else { return }
                self.updateAccounts(appendAccounts: accounts)
                self.paginationMode.moveToNextOffset()
            }
            .store(in: &subscriptions)
    }
    
    public func refreshData() {
        // check view state must not loading
        
        dataFromServer?.mode = .initial
        fetchTransferList()
    }
    
    private func updateAccounts(appendAccounts accounts: [PersonBankAccount]) {
        guard !accounts.isEmpty else {
            // reach to end
            return
        }

        if dataFromServer == nil {
            dataFromServer = .init(list: accounts, mode: .initial, section: .personBankAccounts)
        } else {
            dataFromServer.append(contentsOf: accounts)
        }
        
        dataUpdated = dataFromServer
    }
}
