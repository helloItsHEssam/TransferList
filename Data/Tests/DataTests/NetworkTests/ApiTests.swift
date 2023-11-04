//
//  File.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import XCTest
@testable import Data

final class ApiTests: XCTestCase {
 
    private var api: Api!

    override func tearDown() {
        api = nil
    }

    func testRealMediaListApiCall() async {
        
        // given
        api = ApiImpl()
        do {

            // when
            let accounts = try await api.callApi(route: .transferList(offset: 1),
                                                 decodeType: [PersonBankAccountDTO].self)

            // then
            XCTAssertEqual(accounts.count, 10)
            XCTAssertEqual(accounts.first?.person?.full_name, "Jemimah Sprott")
            XCTAssertEqual(accounts.first?.person?.email, nil)
            XCTAssertEqual(accounts.first?.card?.card_number, "5602217292772382")

        } catch {
            // then
            XCTAssertNil(error as? NetworkError)
        }
    }

    func testSuccessMockResponse() async {
        
        // given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [ResponseMockURLProtocol.self]
        let api = ApiImpl(configuration: configuration)

        do {
            // when
            let accounts = try await api.callApi(route: .transferList(offset: 10),
                                          decodeType: [PersonBankAccountDTO].self)
            
            // then
            XCTAssertEqual(accounts.count, 2)
            XCTAssertEqual(accounts.first?.person?.full_name, "Jemimah Sprott")
            XCTAssertEqual(accounts.first?.person?.email, nil)
            XCTAssertEqual(accounts.first?.card?.card_number, "5602217292772382")
            
        } catch {

            // then
            XCTAssertNil(error)
        }
    }
    
    func testSuccessEmptyMockResponse() async {
        
        // given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [ResponseMockURLProtocol.self]
        let api = ApiImpl(configuration: configuration)

        do {
            // when
            let accounts = try await api.callApi(route: .transferList(offset: 11),
                                          decodeType: [PersonBankAccountDTO].self)
            
            // then
            XCTAssertTrue(accounts.isEmpty)
            
        } catch {

            // then
            XCTAssertNil(error)
        }
    }
    
    func testOfflineApiCall() async {
        // given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [OfflineServerMockURLProtocol.self]
        let api = ApiImpl(configuration: configuration)

        do {
            // when
            let _ = try await api.callApi(route: .transferList(offset: 10),
                                          decodeType: [PersonBankAccountDTO].self)

        } catch {

            // then
            let networkError = error as? NetworkError
            XCTAssertNotNil(networkError)
            XCTAssertEqual(networkError, .cannotConnectToServer)
        }
    }
    
    func testBadResponseApiCall() async {
        
        // given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [BadResponseMockURLProtocol.self]
        let api = ApiImpl(configuration: configuration)

        do {

            // when
            let _ = try await api.callApi(route: .transferList(offset: 10),
                                          decodeType: [PersonBankAccountDTO].self)

        } catch {

            // then
            let networkError = error as? NetworkError
            XCTAssertNotNil(networkError)
            XCTAssertEqual(networkError, .cannotParseJson)
        }
    }
}
