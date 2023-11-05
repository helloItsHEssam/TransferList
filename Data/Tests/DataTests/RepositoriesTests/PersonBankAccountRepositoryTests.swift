//
//  PersonBankAccountRepositoryTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import XCTest
import Domain
@testable import Data

final class PersonBankAccountRepositoryTests: XCTestCase {
    
    var repository: PersonBankAccountRepository!
    
    override func tearDown() {
        repository = nil
    }
    
    func testSuccessFetchTransferList() async {
        
        // given
        repository = PersonBankAccountRepositoryImpl(api: MockApi(),
                                                     local: MockLocal())
        
        do {
            // when
            let accounts = try await repository.fetchPersonAccounts(withOffest: 10)
            
            // then
            XCTAssertEqual(accounts.count, 1)
            XCTAssertEqual(accounts.first?.person?.name, "hessam")
            XCTAssertEqual(accounts.first?.person?.email, "h.mahdi")
            XCTAssertEqual(accounts.first?.card?.cardNumber, "123")
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
    
    func testFailFetchTransferList() async {
        
        // given
        repository = PersonBankAccountRepositoryImpl(api: MockFailConnectToServerApi()
                                                     , local: MockLocal())
        
        do {
            // when
            let _ = try await repository.fetchPersonAccounts(withOffest: 10)
            
        } catch {
            
            // then
            XCTAssertNotNil(error)
        }
    }
    
    func testSuccessSaveToFavorite() async {
        // given
        let local = MockLocal()
        repository = PersonBankAccountRepositoryImpl(api: MockFailConnectToServerApi()
                                                     , local: local)
        
        do {
            // when
            let account = try await repository.savePersonAccountToFavorites(local.createAccount())
            XCTAssertEqual(account.isFavorite, true)
            
        } catch {
            // then
            XCTAssertNotNil(error)
        }
    }
    
    func testSuccessRemoveFromFavorite() async {
        // given
        let local = MockSucceesRemoveLocal()
        repository = PersonBankAccountRepositoryImpl(api: MockFailConnectToServerApi()
                                                     , local: local)
        
        do {
            // when
            let account = try await repository.removePersonAccountFromFavorites(local.createAccount())
            XCTAssertEqual(account.isFavorite, false)
            
            let accounts = try await repository.fetchFavoritePersonAccounts()
            XCTAssertTrue(accounts.isEmpty)
            
        } catch {
            // then
            XCTAssertNotNil(error)
        }
    }
    
    func testFailSaveFromFavorite() async {
        // given
        let local = MockFailSaveOrRemoveLocal()
        repository = PersonBankAccountRepositoryImpl(api: MockFailConnectToServerApi()
                                                     , local: local)
        
        do {
            // when
            let _ = try await repository.savePersonAccountToFavorites(local.createAccount())
            
            let accounts = try await repository.fetchFavoritePersonAccounts()
            XCTAssertTrue(accounts.isEmpty)
            
        } catch {
            // then
            XCTAssertEqual(error as? LocalError, .cannotSavePersonAccountToFavorites)
        }
    }
    
    func testFailRemoveFromFavorite() async {
        // given
        let local = MockFailSaveOrRemoveLocal()
        repository = PersonBankAccountRepositoryImpl(api: MockFailConnectToServerApi()
                                                     , local: local)
        
        do {
            // when
            let _ = try await repository.removePersonAccountFromFavorites(local.createAccount())
            
        } catch {
            // then
            XCTAssertEqual(error as? LocalError, .cannotRemovePersonAccountFromFavorites)
        }
    }
    
    func testSuccessFetchFavoriteAccounts() async {
        
        // given
        let local = MockFailFetchFavoriteAccountLocal()
        repository = PersonBankAccountRepositoryImpl(api: MockApi(),
                                                     local: local)
        
        do {
            // when
            let _ = try await repository.fetchFavoritePersonAccounts()
            
        } catch {
            // then
            XCTAssertEqual(error as? LocalError, .cannotFetchFavorites)
        }
    }
    
    func testSuccessUpdateFavoriteStatus() async {
        
        // given
        let local = MockLocal()
        repository = PersonBankAccountRepositoryImpl(api: MockApi(),
                                                     local: local)
        
        // when
        do {
            let _ = try await repository.savePersonAccountToFavorites(local.createAccount())
            let account = await repository.updatefavoriteStatusBasedOnFavorites(local.createAccount())
            
            XCTAssertEqual(account.isFavorite, true)
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
    
    func testDoesNotUpdateFavoriteStatus() async {

        // given
        let local = MockDoesNotExistInFavoriteLocal()
        repository = PersonBankAccountRepositoryImpl(api: MockApi(),
                                                     local: local)
        
        // when
        do {
            let _ = try await repository.savePersonAccountToFavorites(local.createAccount())
            let account = await repository.updatefavoriteStatusBasedOnFavorites(local.createAccount())
            
            XCTAssertEqual(account.isFavorite, false)
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
}
