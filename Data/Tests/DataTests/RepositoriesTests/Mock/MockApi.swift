//
//  File.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
@testable import Data

final class MockApi: Api {
    
    func callApi<T>(route: ApiRouter, decodeType type: T.Type) async throws -> T where T : Decodable {
        let person = PersonDTO(fullName: "hessam", email: "h.mahdi", avatar: nil)
        let card = CardDTO(cardNumber: "123", cardType: "master")
        let cardCount = CardTransferCountDTO(numberOfTransfers: 12, totalTransfer: 12)
        let note = "note"
        let account = PersonBankAccountDTO(person: person, card: card,
                                           moreInfo: cardCount, note: note,
                                           lastTransfer: nil)
        
        guard let retVal = [account] as? T else {
            throw NetworkError.cannotParseJson
        }
        
        return retVal
    }
}

final class MockFailConnectToServerApi: Api {
    
    func callApi<T>(route: ApiRouter, decodeType type: T.Type) async throws -> T where T : Decodable {
        throw NetworkError.cannotConnectToServer
    }
}
