//
//  ResponseMockURLProtocol.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

class ResponseMockURLProtocol: URLProtocol {
    
    private static var mockResponses = createMockResponse()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url {
            if let apiResponse = ResponseMockURLProtocol.mockResponses[url] {
                if let response = apiResponse.httpResponse {
                    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                }
                if let data = apiResponse.data {
                    client?.urlProtocol(self, didLoad: data)
                }
                if let error = apiResponse.error {
                    client?.urlProtocol(self, didFailWithError: error)
                }
            }
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {}
    
    private static func createMockResponse() -> [URL: ApiMockResponse] {
        
        let strUrl = "https://191da1ac-768c-4c6a-80ad-b533beafec25.mock.pstmn.io/transfer-list/10"
        let url = URL(string: strUrl)!
        let data = #"""
[
    {
        "person": {
            "full_name": "Jemimah Sprott",
            "email": null,
            "avatar": "https://www.dropbox.com/s/64y9lcnca22p1jx/avatar1.png?dl=1"
        },
        "card": {
            "card_number": "5602217292772382",
            "card_type": "bankcard"
        },
        "last_transfer": "2022-08-31T15:24:16Z",
        "note": null,
        "more_info": {
            "number_of_transfers": 74,
            "total_transfer": 83111687
        }
    },
    {
        "person": {
            "full_name": "Bondy Lathleiff",
            "email": "blathleiff1@mozilla.com",
            "avatar": "https://www.dropbox.com/s/64y9lcnca22p1jx/avatar1.png?dl=1"
        },
        "card": {
            "card_number": "5602250166453938",
            "card_type": "bankcard"
        },
        "last_transfer": "2023-02-06T10:51:10Z",
        "note": null,
        "more_info": {
            "number_of_transfers": 81,
            "total_transfer": 37807212
        }
    }
]
"""#.data(using: .utf8)
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)
        let response = ApiMockResponse(url: url, data: data,
                                       httpResponse: httpResponse,
                                       error: nil)
        
        let strUrl2 = "https://191da1ac-768c-4c6a-80ad-b533beafec25.mock.pstmn.io/transfer-list/11"
        let url2 = URL(string: strUrl2)!
        let data2 = #"""
[
]
"""#.data(using: .utf8)
        let httpResponse2 = HTTPURLResponse(url: url, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)
        let response2 = ApiMockResponse(url: url2, data: data2,
                                       httpResponse: httpResponse2,
                                       error: nil)
        
        let strUrl3 = "https://191da1ac-768c-4c6a-80ad-b533beafec25.mock.pstmn.io/transfer-list/-1"
        let url3 = URL(string: strUrl3)!
        let data3 = #"""
{
    "error": "page-number starts from 1"
}
"""#.data(using: .utf8)
        let httpResponse3 = HTTPURLResponse(url: url, statusCode: 400,
                                           httpVersion: nil, headerFields: nil)
        let response3 = ApiMockResponse(url: url3, data: data3,
                                       httpResponse: httpResponse3,
                                       error: nil)
        
        return [url: response, url2: response2, url3: response3]
    }
}
