//
//  File.swift
//  SharedResources
//
//  Created by Marwan Osama on 08/03/2026.
//

import Foundation
internal import Alamofire
import UIKit

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




class UploadMediaUIModel {
    var id: String
    var uploadedMedia: ModelUploadedMedia?
    var state: UploadingState
    var request: UploadRequest?

    init(
        id: String, uploadedMedia: ModelUploadedMedia? = nil,
        state: UploadingState, request: UploadRequest? = nil
    ) {
        self.id = id
        self.uploadedMedia = uploadedMedia
        self.state = state
        self.request = request
    }

    enum UploadingState {
        case failed, success
        case inProgress(Double)
    }
}

struct ModelUploadedMedia : Mappable, Codable, FormValue {

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
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
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

public struct AdditionalProperty : Codable {
    public var contentType : String?
    public var isRequired : Bool?
    public var isVisible : Bool?
    public var id : String?
    public var label : String?
    public var name : String?
    public var placeHolder : String?
    public var readOnly : Bool?
    public var translations : String?
    public var type : String?
    public var value : String?
    public var validations : [Validations]?

    enum CodingKeys: String, CodingKey {

        case contentType = "contentType"
        case isRequired = "isRequired"
        case isVisible = "isVisible"
        case id = "id"
        case label = "label"
        case name = "name"
        case placeHolder = "placeHolder"
        case readOnly = "readOnly"
        case translations = "translations"
        case type = "type"
        case value = "value"
        case validations = "validations"
        
    }

}

public struct Validations : Codable {
    public var name : ValidationName?
    public var value : String?
    public var message : String?
    public var isValid: Bool = false

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case value = "value"
        case message = "message"
    }
}

public enum ValidationName: String, Codable {
    case valueRequired
    case required
    case pattern
    case minlength
    case maxlength
    case min
    case max
    case dateRangeFrom_required = "dateRangeFrom-required"
    case dateRangeTo_required = "dateRangeTo-required"
    case dateFrom_required = "dateFrom-required"
    case dateTo_required = "dateTo-required"
    case timeFrom_required = "timeFrom-required"
    case timeTo_required = "timeTo-required"
    case minRows
    case maxRows
}

public struct MCQOption: Codable, Mappable, Hashable {
    public var id: String?
    public var name: String?
    public var name_ar: String?
    
     init?(map: Map) {
        //empty
    }
    
    public init(id: String?,other: Bool, name: String?, name_ar: String?) {
        self.id = id
        self.name = name
        self.name_ar = name_ar
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        name_ar <- map["name_ar"]
    }
}

public protocol FormValue: Codable {}
extension String: FormValue {}
extension Bool: FormValue {}

public typealias dic = [String:String]
extension dic: FormValue {}


struct ModelLoginCerqel : Mappable, Codable {
    
    var token_type : String?
    var access_token : String?
    var scope : String?
    var expires_in : Int?
    var refresh_token : String?
    var refresh_token_expires_in : Int?
    var mobile: String?

    enum CodingKeys: String, CodingKey {

        case token_type = "token_type"
        case access_token = "access_token"
        case scope = "scope"
        case expires_in = "expires_in"
        case refresh_token = "refresh_token"
        case refresh_token_expires_in = "refresh_token_expires_in"
        case mobile = "mobile"
    }



    init(){}
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        
        token_type <- map["token_type"]
        access_token <- map["access_token"]
        scope <- map["scope"]
        expires_in <- map["expires_in"]
        refresh_token <- map["refresh_token"]
        refresh_token_expires_in <- map["refresh_token_expires_in"]
        mobile <- map["mobile"]

    }

    
}


struct ModelLoginNewCerqel : Codable {
    var data : ModelLoginDataCerqel? = nil
    
    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            data = try values.decodeIfPresent(ModelLoginDataCerqel.self, forKey: .data)
        } catch DecodingError.typeMismatch(_, let error){
            
            print(error)
            print(error.underlyingError)
            print("☢️ Item typemismatch error ignored")

        } catch let err{
            if let err = err as? DecodingError {
                print("☢️☢️☢️  ITEM Decoding Error : \(err) ☢️☢️☢️")
            }
        }
        
    }

}

struct ModelLoginDataCerqel : Mappable, Codable {
    
    var isValid : Bool?
    var token : String?
    var message : String?

    enum CodingKeys: String, CodingKey {

        case isValid = "isValid"
        case token = "token"
        case message = "message"
    }



    init(){}
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        
        isValid <- map["isValid"]
        token <- map["token"]
        message <- map["message"]

    }

}

