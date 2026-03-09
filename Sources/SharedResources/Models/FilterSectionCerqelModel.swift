//
//  SharedCerqelFilterCallBack.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//

import Foundation
@_exported import Promises

public struct SharedCerqelFilterCallBack {
    public var searchText: String?
    public var categoryId: String?
    public var HighlightedFilters : HighlightedFilters?
    public var dateRangeFilter: CerqelDateRangeFilterCerqel?
    public var selectedSections: [SharedCerqelFilterSection]? = []
    public init() {}
}

public struct SharedCerqelFilterSection: Equatable,Hashable {
    public var id: Int
    public var sectionTitle: String
    public var sectionType: SharedCerqelFilterSectionsType
    public var filterCategoriesType: CerqelFilterCategoriesType?
    public var items: [CerqelCategoriesModel]?
    public var collapsed: Bool? = true
    public var endPoint: SharedEndpointService?
    
    
    public init(id: Int, sectionTitle: String, sectionType: SharedCerqelFilterSectionsType, filterCategoriesType: CerqelFilterCategoriesType? = nil, items: [CerqelCategoriesModel]? = nil, collapsed: Bool = true, endPoint: SharedEndpointService = .pin) {
        self.id = id
        self.sectionTitle = sectionTitle
        self.sectionType = sectionType
        self.filterCategoriesType = filterCategoriesType
        self.items = items
        self.collapsed = collapsed
        self.endPoint = endPoint
    }
    
    
    public init() {
        self.id = 0
        self.sectionTitle = ""
        self.sectionType = .categories(.single)
        self.items = []

        self.endPoint = .categories
        self.filterCategoriesType = .type
        self.collapsed = true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static public func == (lhs: SharedCerqelFilterSection, rhs: SharedCerqelFilterSection) -> Bool {
        return lhs.id == rhs.id
    }
    
}

public enum SharedCerqelFilterSectionsEnum: Equatable{
    
    case dateRangeFilter
    case categories(CategoryLevel)
    
    public init() {
        self = .categories(.single)
        
    }
}

public enum CategoryLevel {
    case multi
    case single
}

public enum ToggleValue {
    case on
    case off
    
    public init(_ value: Bool) {
           self = value ? .on : .off
       }
}

public enum SharedCerqelFilterSectionsType: Equatable{
    case dateRangeFilter
    case categories(CategoryLevel)
    case toggle (ToggleValue)
    
}

public enum SharedCerqelFilterSectionEnum: CaseIterable {
    
    case dateRangeFilter
    case categories
}

public enum CerqelFilterCategoriesSectionEnum: CaseIterable {
    case offersCategories
    case documentLibraryCategories
    case type
}


public enum CerqelFilterCategoriesType: CaseIterable {
    case offersCategories
    case categories
    case subCategories
    case acknowledgement
    case type
    case fileTypes
}

public enum CerqelFilterPathEnum: String {
    case offersCategories = "Lookups/Categories/offers"
}

public enum CerqelRepresentationType {
    case CheckBox
    case Radio
}

public enum CerqelCheckBoxRepresentation {
    case CheckBox
    case Radio
}

public struct CerqelCategoriesModel: Codable,Equatable {
    public var id, name: String?
    public var subCategories:[CerqelCategoriesModel]?
    public var isSelected: Bool = false
    public var isHighlighted: Bool = false
    public var representation: CerqelCheckBoxRepresentation = .CheckBox
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public init() {}
    
    public init(id: String? = nil,
                name: String? = nil,
                representation: CerqelCheckBoxRepresentation = .CheckBox,
                subCategories: [CerqelCategoriesModel]? = nil,
                isSelected: Bool = false,
                isHighlighted: Bool = false) {
        self.id = id
        self.name = name
        self.representation = representation
        self.subCategories = subCategories
        self.isSelected = isSelected
        self.isHighlighted = isHighlighted
    }
    
    public init(id: String? = nil,
                name: String? = nil,
                isSelected: Bool = false,
                representation: CerqelCheckBoxRepresentation = .CheckBox) {
        self.id = id
        self.name = name
        self.representation = representation
        self.isSelected = isSelected
    }
}
