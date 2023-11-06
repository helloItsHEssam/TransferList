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
    
//    @Published private(set) var viewState: ViewState = .loading
    @Published var bankAccounts: [PersonBankAccount] = []
//    @Published var path = NavigationPath()
    private let useCase: PersonBankAccountUseCase
    private var subscriptions = Set<AnyCancellable>()
    private var currentOffset: Int = 0
    
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
        
        useCase.fetchPersonAccounts(withOffest: currentOffset + 1)
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
            }
            .store(in: &subscriptions)
    }
    
    func updateAccounts(appendAccounts accounts: [PersonBankAccount]) {
        guard !accounts.isEmpty else {
            // reach to end
            return
        }
        
        bankAccounts.append(contentsOf: accounts)
        currentOffset += 1
    }
    
//    func fetchMediaList() {
//        guard mediaList.isEmpty else {
//            return
//        }
//
//        updateViewState(newState: .loading)
//
//        useCase.fetchMediaList()
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                guard let self else { return }
//                switch completion {
//                case .failure(let error):
//                    let alertContent = AlertContent(message: error.localizedDescription)
//                    self.updateViewState(newState: .error(alertContent: alertContent))
//                case .finished: break
//                }
//            } receiveValue: { [weak self] mediaList in
//                self?.mediaList = mediaList
//                self?.updateViewState(newState: .result)
//            }
//            .store(in: &subscriptions)
//    }
    
//    func fetchMediaImage(WithImageUrl imageUrl: String?, previewImage: @escaping BackImage) {
//        guard let imageUrl else {
//            previewImage(Image("imageFailed"))
//            return
//        }
//
//        useCase.fetchImage(withImageUrl: imageUrl)
//            .retry(3)
//            .replaceError(with: Image("imageFailed"))
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { image in
//                previewImage(image)
//            })
//            .store(in: &subscriptions)
//    }
}

