//
//  CerqelListModel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation

public struct CerqelListModel: Codable {
    var id: String?
    var collapsed: Bool? = true
    var isSelected: Bool?
    var nameEn: String?
    var nameAr: String?
    
    public init()  {
        self.isSelected = false
    }
    
    enum CodingKeys: String, CodingKey {
        case id,collapsed
        case isSelected
        case nameEn, nameAr
    }
    
    public var collapseImage : String {
        return collapsed ?? true  ? "arrow_down" : "arrow_up"
    }
    
}
