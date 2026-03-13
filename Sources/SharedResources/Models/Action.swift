//
//  File.swift
//  SharedResources
//
//  Created by Marwan Osama on 05/03/2026.
//

import Foundation

public struct Action : Codable, Mappable {
   public var id : String?
   public var name : String?
   public var label : String?
   public var actionTakenLabel : String?
   public var styleCode : String?
   public var displayMode: Int?
   public var buttonStyleCode : String?
   public var actionCode : String?
   public var disabledWhenRequiredData: Bool?
   public var isCommentRequired : Bool?
   public var isDimmed : Bool?
   public var isFormValidateBeforeExecuteActionRequired : Bool?
   public var isAttachmentRequired : Bool?
   public var actionFormId: String?
   public var actionOrder: Int?
   public var buttonStyle : ButtonStyle?
    
    init?(map: Map) {}

    public init(id: String?, name: String?, label: String?, actionTakenLabel: String?, styleCode: String?, buttonStyleCode: String?, actionCode: String?, isCommentRequired: Bool?, isFormValidateBeforeExecuteActionRequired: Bool?, isAttachmentRequired: Bool?, actionFormId: String?, actionOrder: Int?, buttonStyle : ButtonStyle?, displayMode: Int?) {
        self.id = id
        self.name = name
        self.label = label
        self.actionTakenLabel = actionTakenLabel
        self.styleCode = styleCode
        self.buttonStyleCode = buttonStyleCode
        self.actionCode = actionCode
    self.displayMode = displayMode
        self.isCommentRequired = isCommentRequired
        self.isFormValidateBeforeExecuteActionRequired = isFormValidateBeforeExecuteActionRequired
        self.isAttachmentRequired = isAttachmentRequired
        self.actionFormId = actionFormId
        self.actionOrder = actionOrder
        self.buttonStyle = buttonStyle
    }
    public init() {
        self.id = ""
        self.name = ""
        self.label = ""
        self.actionTakenLabel = ""
        self.styleCode = ""
        self.buttonStyleCode = ""
        self.actionCode = ""
        self.isCommentRequired = false
        self.isFormValidateBeforeExecuteActionRequired = false
        self.isAttachmentRequired = false
        self.actionFormId = ""
    self.displayMode = 1
        self.actionOrder = 0
        self.buttonStyle = ButtonStyle()
    }
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case label = "label"
        case actionTakenLabel = "actionTakenLabel"
        case styleCode = "styleCode"
        case buttonStyleCode = "buttonStyleCode"
        case actionCode = "actionType"
        case disabledWhenRequiredData = "disabledWhenRequiredData"
        case displayMode = "displayMode"
        case isCommentRequired = "isCommentRequired"
        case isFormValidateBeforeExecuteActionRequired = "isFormValidateBeforeExecuteActionRequired"
        case isAttachmentRequired = "isAttachmentRequired"
        case actionFormId, actionOrder
        case buttonStyle
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        label <- map["label"]
        actionTakenLabel <- map["actionTakenLabel"]
        styleCode <- map["styleCode"]
        buttonStyleCode <- map["buttonStyleCode"]
        actionCode <- map["actionType"]
        disabledWhenRequiredData <- map["disabledWhenRequiredData"]
        isCommentRequired <- map["isCommentRequired"]
        isFormValidateBeforeExecuteActionRequired <- map["isFormValidateBeforeExecuteActionRequired"]
        isAttachmentRequired <- map["isAttachmentRequired"]
        actionFormId <- map["actionFormId"]
        actionOrder <- map["actionOrder"]
        buttonStyle <- map["buttonStyle"]
    var modeStr: String?
           modeStr <- map["displayMode"]
           switch modeStr?.lowercased() {
           case "direct":
               displayMode = 1
           case "inlist":
               displayMode = 2
           default:
               displayMode = nil
           }
    }

    // Helper: "Direct" -> 1, "InList" -> 2
       private static func displayModeInt(from mode: String?) -> Int? {
           switch mode?.lowercased() {
           case "direct": return 1
           case "inlist": return 2
           default: return nil
           }
       }
}

public struct ButtonStyle: Codable, Mappable {
    public var backgroundColor: String?
    public var borderColor: String?
    public var textColor: String?
    public var opacity: Float?
    
    public init() {
        self.backgroundColor = ""
        self.borderColor = ""
        self.textColor = ""
        self.opacity = 0.0
    
    }
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        backgroundColor <- map["backgroundColor"]
        borderColor <- map["borderColor"]
        textColor <- map["textColor"]
        opacity <- map["opacity"]
    }
}
