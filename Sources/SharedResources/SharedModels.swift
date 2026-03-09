//
//  File.swift
//  SharedResources
//
//  Created by Marwan Osama on 08/03/2026.
//

import Foundation
internal import Alamofire
import UIKit

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

