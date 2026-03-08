//
//  ListDTOModel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation

public struct ListDTOModel: Identifiable {
    public let id: Int
    public let title: String
    public var isSelected: Bool

    public init(id: Int, title: String, isSelected: Bool) {
        self.id = id
        self.title = title
        self.isSelected = isSelected
    }

    public init() {
        self.id = 0
        self.title = ""
        self.isSelected = false

    }
}
