//
//  Mapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation

public protocol Mapper {

    associatedtype Entity
    associatedtype Dto

    func mapEntityToDto(input: Entity) -> Dto
    func mapDtoToEntity(input: Dto) -> Entity
}

public extension Mapper {

    func mapEntitiesToDtos(input: [Entity]) -> [Dto] {
        return input.map { mapEntityToDto(input: $0) }
    }

    func mapDtosToEntities(input: [Dto]) -> [Entity] {
        return input.map { mapDtoToEntity(input: $0) }
    }
}

