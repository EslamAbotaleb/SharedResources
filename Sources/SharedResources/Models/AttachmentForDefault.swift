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
    
    public init?(map: Map) {}
    
    public init?(id: String, name: String, fileExtension: String) {
        self.fileId = id
        self.fileName = name
        self.fileExtension = fileExtension
    }

    mutating public func mapping(map: Map) {
        fileId <- map["attachmentId"]
        fileName <- map["attachmentName"]
        fileExtension <- map["attachmentExtension"]    
    }
    
    enum CodingKeys: String, CodingKey {
        case fileId = "attachmentId"
        case fileName = "attachmentName"
        case fileExtension = "attachmentExtension"
    }

}

public enum ValueType: Codable, Mappable {
    
    case singleDouble(Double)
    case double([Double])
    case singleString(String)
    case listOfString([String])
    case dictionary([[String: String?]])
    case file([AttachmentForDefault])
    case empty
    case ddl(DDL)
    case bcDDL(BCDDL)
    case bool([Bool])
    case singleBool(Bool)
    
    // Codable initializer
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let singleString = try? container.decode(String.self) {
            self = .singleString(singleString)
        } else if let singleDouble = try? container.decode(Double.self) {
            self = .singleDouble(singleDouble)
        } else if let double = try? container.decode([Double].self) {
            self = .double(double)
        } else if let string = try? container.decode([String].self) {
            self = .listOfString(string)
        } else if let nestedString = try? container.decode([[String]].self) {
            let flattenedString = nestedString.flatMap { $0 }.joined(separator: ", ")
            self = .singleString(flattenedString)
        } else if let bcDdl = try? container.decode(BCDDL.self) {
            self = .bcDDL(bcDdl)
        } else if let ddl = try? container.decode(DDL.self) {
            self = .ddl(ddl)
        } else if let dict = try? container.decode([[String: String?]].self) {
            self = .dictionary(dict)
        } else if let file = try? container.decode([AttachmentForDefault].self) {
            self = .file(file)
        } else if let dict = try? container.decode([[String: String]].self) {
            self = .dictionary(dict)
        } else if let bool = try? container.decode([Bool].self) {
            self = .bool(bool)
        } else if let singleBool = try? container.decode(Bool.self) {
            self = .singleBool(singleBool)
        } else {
            self = .empty
        }
    }
    
    // Codable encoder
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .singleDouble(let singleDouble):
            try container.encode(singleDouble)
        case .double(let double):
            try container.encode(double)
        case .singleString(let singleString):
            try container.encode(singleString)
        case .listOfString(let string):
            try container.encode(string)
        case .bcDDL(let bcDDL):
            try container.encode(bcDDL)
        case .dictionary(let dict):
            try container.encode(dict)
        case .file(let file):
            try container.encode(file)
        case .ddl(let ddl):
            try container.encode(ddl)
        case .bool(let bool):
            try container.encode(bool)
        case .singleBool(let singleBool):
            try container.encode(singleBool)
        case .empty:
            return
        }
    }
    
    // Mappable initializer
    public init?(map: Map) {
        self = .empty
    }
    
    // Mappable mapping function
    mutating public func mapping(map: Map) {
        var singleString: String?
        var singleDouble: Double?
        var double: [Double]?
        var string: [String]?
        var dict: [[String: String?]]?
        var file: [AttachmentForDefault]?
        var bool: [Bool]?
        var singleBool: Bool?
        var bcDdl: BCDDL?
        var ddl: DDL?
        
        singleString <- map["Value"]
        singleDouble <- map["Value"]
        double <- map["Value"]
        string <- map["Value"]
        dict <- map["Value"]
        file <- map["Value"]
        bool <- map["Value"]
        singleBool <- map["Value"]
        bcDdl <- map["Value"]
        ddl <- map["Value"]
        
        if let value = singleString {
            self = .singleString(value)
        } else if let value = singleDouble {
            self = .singleDouble(value)
        } else if let value = double {
            self = .double(value)
        } else if let value = string {
            self = .listOfString(value)
        } else if let value = dict {
            self = .dictionary(value)
        } else if let value = file {
            self = .file(value)
        } else if let value = bool {
            self = .bool(value)
        } else if let value = singleBool {
            self = .singleBool(value)
        } else if let value = bcDdl {
            self = .bcDDL(value)
        } else if let value = ddl {
            self = .ddl(value)
        } else {
            self = .empty
        }
    }
}

public struct DDL: Codable, Mappable {
    public var Name: String?
    public var Value: [MCQOption]?
    public var RowIndex: String?
    public var Id: String?
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        Name <- map["name"]
        Value <- map["value"]
        RowIndex <- map["rowIndex"]
        Id <- map["id"]
    }

    enum CodingKeys: String, CodingKey {
        case Name = "name"
        case Value = "value"
        case RowIndex = "rowIndex"
        case Id = "id"
    }
}

public struct BCDDL: Codable, Mappable {
    public var Name: String?
    public var Value: [BCMCQOption]?
    public var RowIndex: String?
    public var Id: String?
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        Name <- map["Name"]
        Value <- map["Value"]
        RowIndex <- map["RowIndex"]
        Id <- map["Id"]
    }

    enum CodingKeys: String, CodingKey {
        case Name = "Name"
        case Value = "Value"
        case RowIndex = "RowIndex"
        case Id = "Id"
    }
}

public struct BCMCQOption: Codable, Mappable, Hashable {
    public var id: String?
    public var name: String?
    public var name_ar: String?
    
    public init?(map: Map) {
        //empty
    }
    
    public init(id: String?,other: Bool, name: String?, name_ar: String?) {
        self.id = id
        self.name = name
        self.name_ar = name_ar
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nameEN"
        case name_ar = "nameAR"
    }
    
    mutating public func mapping(map: Map) {
        id <- map["id"]
        name <- map["nameEN"]
        name_ar <- map["nameAR"]
    }
}
