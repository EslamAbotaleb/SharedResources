//
//  EntityMapper.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//


import Foundation

public protocol EntityMapper {
    associatedtype DTO
    associatedtype Entity
    func map (from dto: DTO) -> Entity
}
