//
//  ModelUploadedMedia.swift
//  SharedResources
//
//  Created by Eslam on 09/03/2026.
//

import Foundation
import UIKit

public struct ModelUploadedMedia : Mappable, Codable, FormValue {

    var downloadUrl: String?
    var previewUrl: String?
    var viewImage: UIImage?
    var contentType: String?
    var documentType: String?
    var fileSize: String?
    var id: String?
    var isPublic: Bool?
    var name: String?
    var isStillUploading: Bool = false
    var additionalProperty01: AdditionalProperty?
    var additionalProperty02: AdditionalProperty?
    var additionalProperty03: AdditionalProperty?
    var additionalProperty04: AdditionalProperty?
    
    enum CodingKeys: String, CodingKey {
        case contentType
        case documentType
        case fileSize
        case id
        case isPublic
        case name
        case additionalProperty01
        case additionalProperty02
        case additionalProperty03
        case additionalProperty04
        case downloadUrl
        case previewUrl
    }
    
    init(downloadUrl: String? = nil,
         previewUrl: String? = nil,
         viewImage: UIImage? = nil,
         contentType: String? = nil,
         documentType: String? = nil,
         fileSize: String? = nil,
         id: String? = nil,
         isPublic: Bool? = nil,
         name: String? = nil,
         isStillUploading: Bool = false,
         additionalProperty01: AdditionalProperty? = nil,
         additionalProperty02: AdditionalProperty? = nil,
         additionalProperty03: AdditionalProperty? = nil,
         additionalProperty04: AdditionalProperty? = nil) {
        
        self.downloadUrl = downloadUrl
        self.previewUrl = previewUrl
        self.viewImage = viewImage
        self.contentType = contentType
        self.documentType = documentType
        self.fileSize = fileSize
        self.id = id
        self.isPublic = isPublic
        self.name = name
        self.isStillUploading = isStillUploading
        self.additionalProperty01 = additionalProperty01
        self.additionalProperty02 = additionalProperty02
        self.additionalProperty03 = additionalProperty03
        self.additionalProperty04 = additionalProperty04
    }
    
    // Implementations for Mappable protocol
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        contentType <- map["contentType"]
        documentType <- map["documentType"]
        fileSize <- map["fileSize"]
        id <- map["id"]
        isPublic <- map["isPublic"]
        name <- map["name"]
        additionalProperty01 <- map["additionalProperty01"]
        additionalProperty02 <- map["additionalProperty02"]
        additionalProperty03 <- map["additionalProperty03"]
        additionalProperty04 <- map["additionalProperty04"]
        downloadUrl <- map["downloadUrl"]
        previewUrl <- map["previewUrl"]
    }
}
