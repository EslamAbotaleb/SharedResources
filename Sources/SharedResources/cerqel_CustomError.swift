//
//  cerqel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation

public struct cerqel_CustomError: LocalizedError {
    public let value: String
    public var localizedDescription: String {
        return value
    }
    
    public init(value: String) {
        self.value = value
    }
}
