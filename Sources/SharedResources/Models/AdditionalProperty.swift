//
//  AdditionalProperty.swift
//  SharedResources
//
//  Created by Eslam on 09/03/2026.
//

import Foundation

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

    public init() {
        
    }
    
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
