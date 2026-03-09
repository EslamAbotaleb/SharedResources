//
//  AttachmentForDefault.swift
//  SharedResources
//
//  Created by Eslam on 09/03/2026.
//

import Foundation

public struct AttachmentForDefault: Mappable, Codable {
    public var fileId: String?
    public var attachmentDisplaySize: String?
    public var fileName: String?
    public var size: String?
    public var isPublic: Bool?
    public var fileExtension: String?
    public var isSuccess: Bool?
    public var previewUrl: String?{
        return  fileId != nil ? "\(cerqel_Environment.Api_Base_URL)Storage/api/FileManager/Preview/\(fileId!)" : nil
    }
    public var downloadUrl: String?{
        return  fileId != nil ? "\(cerqel_Environment.Api_Base_URL)Storage/api/FileManager/Download/\(fileId!)" : nil
    }
    public var fileUrl: String?{
        return  fileId != nil ? "\(cerqel_Environment.Api_Base_URL)Storage/api/FileManager/Preview/\(fileId!)" : nil
    }
    
    init?(map: Map) {}
    
    public init?(id: String, name: String, fileExtension: String) {
        self.fileId = id
        self.fileName = name
        self.fileExtension = fileExtension
    }

    mutating func mapping(map: Map) {
        fileId <- map["attachmentId"]
        fileName <- map["attachmentName"]
        fileExtension <- map["attachmentExtension"]
        //        url <- map["url"]
        //        downloadUrl <- map["downloadUrl"]
        //        attachmentDisplaySize <- map["attachmentDisplaySize"]
        //        previewUrl <- map["previewUrl"]
        //        size <- map["size"]
        //        isPublic <- map["isPublic"]
        //        fileUrl <- map["fileUrl"]
        //        isSuccess <- map["isSuccess"]
    
    }
    
    enum CodingKeys: String, CodingKey {
        case fileId = "attachmentId"
        case fileName = "attachmentName"
        case fileExtension = "attachmentExtension"
    }

}
