//
//  ApiRouterTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import XCTest
@testable import Data

final class ApiRouterTests: XCTestCase {

    func testGetHttpMethod() {
        // given
        let route = ApiRouter.transferList(offset: 1)
        
        // when
        let httpMethod = route.getHttpMethod()
        
        // then
        XCTAssertEqual(httpMethod, .get)
        XCTAssertNotEqual(httpMethod, .post)
    }
    
    func testPath() {
        // given
        let route = ApiRouter.transferList(offset: 1)
        
        // when
        let path = route.urlPath
        
        // then
        XCTAssertEqual(path, "/transfer-list/1")
    }
    
    func testCreateURL() {
        // given
        let route = ApiRouter.transferList(offset: 1)
        
        // when
        let url = route.createURL()
        
        // then
        XCTAssertEqual(url.absoluteString, "https://191da1ac-768c-4c6a-80ad-b533beafec25.mock.pstmn.io/transfer-list/1")
    }
}
