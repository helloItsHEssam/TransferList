//
//  PersonBankAccountUseCaseTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import XCTest
import Combine
@testable import Domain

final class PersonBankAccountUseCaseTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    var useCase: PersonBankAccountUseCase!
    
    override func setUp() {
        cancellables = []
    }
    
    override func tearDown() {
        useCase = nil
        cancellables.removeAll()
    }
    
    
    func testSuccessFetchPersonAccounts() {
        // given
        let repository = MockSuccessFetchAccountRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "fetch accounts")
        
        var accounts: [PersonBankAccount]?
        
        // when
        useCase.fetchPersonAccounts(withOffest: 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { values in
                accounts = values
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertNotNil(accounts)
        XCTAssertEqual(accounts?.count, 1)
    }
    
    func testSuccessEmptyFetchPersonAccounts() {
        // given
        let repository = MockSuccessEmptyFetchAccountRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "fetch accounts")
        
        var accounts: [PersonBankAccount]?
        
        // when
        useCase.fetchPersonAccounts(withOffest: 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { values in
                accounts = values
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertNotNil(accounts)
        XCTAssertTrue(accounts?.isEmpty ?? false)
    }
    
    func testFailFetchPersonAccounts() {
        
        // given
        let repository = MockPersonBankAccountRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "fetch accounts")
        
        var error: PersonBankAccountError?

        // when
        useCase.fetchPersonAccounts(withOffest: 1)
            .sink { completion in
                switch completion {
                case .failure(let perEror): error = perEror
                case .finished: break
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)

        // then
        XCTAssertNotNil(error)
        XCTAssertEqual(error, .cannotFetchPersonAccounts)
    }
    
    func testSuccessFetchFavoritePersonAccounts() {
        // given
        let repository = MockSuccessFetchAccountRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "fetch accounts")
        
        var accounts: [PersonBankAccount]?
        
        // when
        useCase.fetchFavoritePersonAccounts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { values in
                accounts = values
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertNotNil(accounts)
        XCTAssertEqual(accounts?.count, 1)
        XCTAssertEqual(accounts?.first?.isFavorite, true)
    }
    
    func testFailFetchFavoritePersonAccounts() {
        
        // given
        let repository = MockPersonBankAccountRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "fetch accounts")
        
        var error: PersonBankAccountError?

        // when
        useCase.fetchFavoritePersonAccounts()
            .sink { completion in
                switch completion {
                case .failure(let perEror): error = perEror
                case .finished: break
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)

        // then
        XCTAssertNotNil(error)
        XCTAssertEqual(error, .cannotFetchFavoritePersonAccounts)
    }
    
    func testSuccessSavePersonAccount() {
        // given
        let repository = MockSuccessSaveOrRemoveAccountToFavoritesRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "save account")
        
        let mockAccount = repository.createMockPersonAccount()
        var accounts: [PersonBankAccount]?
        
        // when
        useCase.savePersonAccountToFavorites(mockAccount)
            .sink { _ in } receiveValue: { _ in }.store(in: &cancellables)

        
        useCase.fetchFavoritePersonAccounts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { values in
                accounts = values
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertEqual(accounts?.count, 1)
        XCTAssertEqual(accounts?.first?.person?.name, mockAccount.person?.name)
        XCTAssertEqual(accounts?.first?.isFavorite, true)
    }
    
    func testSuccessRemovePersonAccount() {
        // given
        let repository = MockSuccessSaveOrRemoveAccountToFavoritesRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "remove account")
        
        let mockAccount = repository.createMockPersonAccount()
        var accounts: [PersonBankAccount]?
        
        func runFetchFavorite() {
            useCase.fetchFavoritePersonAccounts()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in
                }, receiveValue: { values in
                    accounts = values
                    expectation.fulfill()
                })
                .store(in: &cancellables)
        }
        
        func runRemove() {
            useCase.removePersonAccountFromFavorites(mockAccount)
                .sink { _ in
                    runFetchFavorite()
                } receiveValue: { _ in }.store(in: &cancellables)
        }
        
        // when
        useCase.savePersonAccountToFavorites(mockAccount)
            .sink { _ in
                runRemove()
            } receiveValue: { _ in }.store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertEqual(accounts?.count, 1)
        XCTAssertEqual(accounts?.first?.person?.name, mockAccount.person?.name)
        XCTAssertEqual(accounts?.first?.isFavorite, false)
    }
    
    func testFailSavePersonAccount() {
        // given
        let repository = MockSuccessFetchAccountRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "save account")
        
        let mockAccount = repository.createMockPersonAccount()
        var error: PersonBankAccountError?
        
        // when
        useCase.savePersonAccountToFavorites(mockAccount)
            .sink { completion in
                switch completion {
                case .failure(let perEror): error = perEror
                case .finished: break
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertNotNil(error)
        XCTAssertEqual(error, .cannotSavePersonAccountToFavorites)
    }
    
    func testFailRemovePersonAccount() {
        // given
        let repository = MockSuccessFetchAccountRepository()
        useCase = PersonBankAccountUseCaseImpl(repository: repository)
        
        let expectation = XCTestExpectation(description: "remove account")
        
        let mockAccount = repository.createMockPersonAccount()
        var error: PersonBankAccountError?
        
        // when
        useCase.removePersonAccountFromFavorites(mockAccount)
            .sink { completion in
                switch completion {
                case .failure(let perEror): error = perEror
                case .finished: break
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertNotNil(error)
        XCTAssertEqual(error, .cannotRemovePersonAccountFromFavorites)
    }
}
