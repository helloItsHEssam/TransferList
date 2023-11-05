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
    
    func testSuccessFetchMediaList() async {
        
        // given
        repository = PersonBankAccountRepositoryImpl(api: MockApi())
        
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

    func testFailFetchMediaList() async {

        // given
        repository = PersonBankAccountRepositoryImpl(api: MockFailConnectToServerApi())

        do {
            // when
            let _ = try await repository.fetchPersonAccounts(withOffest: 10)

        } catch {

            // then
            XCTAssertNotNil(error)
        }
    }
}
