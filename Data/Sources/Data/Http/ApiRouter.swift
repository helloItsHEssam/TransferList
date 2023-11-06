//
//  ApiRouter.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Alamofire

public enum ApiRouter: URLRequestConvertible {
    
    public typealias Params = [String: Any]
    
    case transferList(offset: Int)
    
    public func asURLRequest() throws -> URLRequest {
        
        let httpMethod = getHttpMethod()
        let url = createURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval = 20.0
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        let encoding: ParameterEncoding = {
            switch httpMethod {
            default:
                return URLEncoding.queryString
            }
        }()
        
        return try encoding.encode(urlRequest, with: self.getParams())
    }
}

public extension ApiRouter {
    
    func getHttpMethod() -> HTTPMethod {
        switch self {
        case .transferList:
            return .get
        }
    }
    
    func getParams() -> Params? {
        return nil
    }
    
    var urlPath: String {
        switch self {
        case .transferList(let offset):
            return "/transfer-list/\(offset)"
        }
    }
    
    func createURL() -> URL {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "191da1ac-768c-4c6a-80ad-b533beafec25.mock.pstmn.io"
        component.path = urlPath
        return component.url!
    }
}
