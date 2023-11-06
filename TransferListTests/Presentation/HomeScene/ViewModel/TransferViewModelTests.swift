//
//  TransferViewModelTests.swift
//  TransferListTests
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import XCTest
import Combine
import Domain
@testable import TransferList

final class TransferViewModelTests: XCTestCase {

    var cancellables: Set<AnyCancellable>!
    var viewModel: TransferViewModel!
    
    override func setUp() {
        cancellables = []
        viewModel = ViewModelFactory.shared.createMediaViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
    }

    func testViewState() {

        // given
        let expectation = XCTestExpectation(description: "change view state")
        var newState: ViewState?

        // when
        viewModel.fetchTransferList()

        viewModel.$viewState
            .first()
            .sink { state in
                newState = state
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)

        // then
        XCTAssertNotNil(newState)
        XCTAssertEqual(newState, .loading)
    }
    
    func testFetchTransferList() {
        
        // given
        let expectation = XCTestExpectation(description: "fetch transfer list")
        var dataTransfer: DataTransfer<PersonBankAccount>!
        
        // when
        viewModel.fetchTransferList()
        
        viewModel.accountsNeedToShow
            .sink { data in
                dataTransfer = data
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
        
        // then
        XCTAssertEqual(dataTransfer.list.count, 10)
    }
    
    func testFetchFavoriteList() {
        
        // given
        let expectation = XCTestExpectation(description: "fetch transfer list")
        var dataTransfer: DataTransfer<PersonBankAccount>!
        
        // when
        viewModel.saveToFavorite(account: .init(person: Person(name: "hes", email: nil,
                                                               avatar: nil), card: .init(cardNumber: "134", cardType: nil), cardTransferCount: nil, note: nil, lastDateTransfer: nil))
        
        viewModel.favoriteStatusUpdated
            .sink { [weak self] _ in
                self?.viewModel.fetchFavoriteList()
            }.store(in: &cancellables)
                
        viewModel.accountsNeedToShow
            .sink { data in
                dataTransfer = data
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
        
        // then
        XCTAssertEqual(dataTransfer.list.first?.person?.name, "hes")
    }
}
