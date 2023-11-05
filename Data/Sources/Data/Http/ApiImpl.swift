//
//  ApiImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import Alamofire

final public class ApiImpl: Api {
    
    private var sessionManager: Session
    private var decoder: JSONDecoder!
    
#if DEBUG
    public init(configuration: URLSessionConfiguration) {
        sessionManager = Session(configuration: configuration)
        setupDecoder()
    }
#endif
    
    public init() {
        sessionManager = Session()
        setupDecoder()
    }
    
    private func setupDecoder() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    public func callApi<T: Decodable>(route: ApiRouter, decodeType type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: NetworkError.cannotConnectToServer)
                return
            }
            
            sessionManager.request(route)
                .validate(statusCode: 200 ..< 300)
                .responseData { [weak self] responseData in
                    guard let self else {
                        continuation.resume(throwing: NetworkError.cannotParseJson)
                        return
                    }

                    switch responseData.result {
                    case .success(let data):
                        do {
                            let retVal = try decoder.decode(type, from: data)
                            continuation.resume(returning: retVal)
                        } catch {
                            continuation.resume(throwing: NetworkError.cannotParseJson)
                        }
                        
                    case .failure:
                        continuation.resume(throwing: NetworkError.cannotConnectToServer)
                    }
                }
        }
    }
}
