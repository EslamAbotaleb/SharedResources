//
//  VisitorInfoCerqel.swift
//  SharedResources
//
//  Created by Eslam on 13/03/2026.
//


public struct VisitorInfoCerqel : Codable, Mappable, FormValueCerqel {
    public var name : String?
    public var mobileNumber : String?
    public var nationalPassport : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case mobileNumber = "mobileNumber"
        case nationalPassport = "nationalPassport"
    }
    
    public func encode(to encoder: Encoder) throws {}

    
    public init(){}
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        name <- map["name"]
        mobileNumber <- map["mobileNumber"]
        nationalPassport <- map["nationalPassport"]

    }

    public func validate()-> Bool{
        if let _ = name, let _ = nationalPassport, let _ = mobileNumber{
            return true
        }
        return false
    }
}
