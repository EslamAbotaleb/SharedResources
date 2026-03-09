//
//  AttachmentsCerqel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation

public struct AttachmentsCerqel : Codable {
    public let attachmentID : String?
    public let attachmentType : String?
    public let attachmentURL : String?
    public let attachmentName : String?
    public let attachmentExtension : String?
    public let attachmentSize : Double?
    public let attachmentDisplaySize : String?

    enum CodingKeys: String, CodingKey {
        case attachmentID = "attachmentID"
        case attachmentType = "attachmentType"
        case attachmentURL = "attachmentURL"
        case attachmentName = "attachmentName"
        case attachmentExtension = "attachmentExtension"
        case attachmentSize = "attachmentSize"
        case attachmentDisplaySize = "attachmentDisplaySize"
    }
    
    public init(attachmentID: String?, attachmentType: String?, attachmentURL: String?, attachmentName: String?, attachmentExtension: String?, attachmentSize: Double?, attachmentDisplaySize: String?) {
        self.attachmentID = attachmentID
        self.attachmentType = attachmentType
        self.attachmentURL = attachmentURL
        self.attachmentName = attachmentName
        self.attachmentExtension = attachmentExtension
        self.attachmentSize = attachmentSize
        self.attachmentDisplaySize = attachmentDisplaySize
    }
}
