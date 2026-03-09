//
//  SharedFilterModelCerqel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation

public struct SharedFilterModelCerqel {
    var orignalDateRangeFilter: CerqelDateRangeFilterCerqel?
    var dateRangeFilter: CerqelDateRangeFilterCerqel?
    var categories: [SharedFilterCategory]? = []
}

public struct SharedFilterCategory {
    var selectedCategories: [SharedCategories] = []
    var representation: CerqelCheckBoxRepresentation
    var isAnotherLvl: Bool
}

public struct SharedCategories: Codable,Equatable {
    var id, name: String?
    var subCategories:[SharedCategories]?
    var isSelected: Bool = false
    var representation: CerqelCheckBoxRepresentation = .CheckBox
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

public struct CerqelDateRangeFilterCerqel {
    public var date1: Date?
    public var date2: Date?
    public init() {}
    public init(date1: Date?, date2: Date?) {
        self.date1 = date1
        self.date2 = date2
    }
}
