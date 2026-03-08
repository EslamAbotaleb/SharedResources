//
//  FileVersion.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation

public enum FileVersion: String{
    case arabic = "arabic"
    case english = "english"
}

public struct FileRequest {
    public var data: Data
    public var fileName: String
    public var extenstion : FileType
    
    public init(data: Data, fileName: String, extenstion: FileType) {
        self.data = data
        self.fileName = fileName
        self.extenstion = extenstion
    }
}

public struct FileEntity {
    public var uploadExtension: FileType
    public var file: FileRequest
    public var FileType: FileVersionType
    public var isPublic: Bool
    public var serviceType: Int?
 
    public init(uploadExtension: FileType, file: FileRequest, FileType: FileVersionType, isPublic: Bool, serviceType: Int? = nil) {
        self.uploadExtension = uploadExtension
        self.file = file
        self.FileType = FileType
        self.isPublic = isPublic
        self.serviceType = serviceType
    }
}
