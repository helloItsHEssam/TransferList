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
        let person = PersonDTO(full_name: "hessam", email: "h.mahdi", avatar: nil)
        let card = CardDTO(card_number: "123", card_type: "master")
        let cardCount = CardTransferCountDTO(number_of_transfers: 12, total_transfer: 12)
        let note = "note"
        let account = PersonBankAccountDTO(person: person, card: card,
                                           more_info: cardCount, note: note,
                                           last_transfer: nil)
        
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
