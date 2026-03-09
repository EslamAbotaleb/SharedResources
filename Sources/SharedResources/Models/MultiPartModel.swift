//
//  MultiPartModel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//


import Foundation

public struct MultiPartModel {
    public var data: Data
    public var fileName, mimeType, keyName: String
    
    public init(data: Data, fileName: String, mimeType: String, keyName: String) {
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
        self.keyName = keyName
    }
}
