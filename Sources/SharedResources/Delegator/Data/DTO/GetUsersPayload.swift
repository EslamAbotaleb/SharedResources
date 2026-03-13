//
//  GetUsersPayload.swift
//  CERQEL
//
//  Created by Youxel on 13/05/2024.
//  Copyright © 2024 Youxel. All rights reserved.
//

import Foundation

public struct GetUsersPayload: Codable, Mappable {
    public var filter : UserFilterModel?
    public var searchOptions : String?
    public var pageSize : Int?
    public var pageNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case filter = "filter"
        case searchOptions = "searchOptions"
        case pageSize = "pageSize"
        case pageNumber = "pageNumber"
    }
    
    init?(map: Map) {
        
    }
    public init() {
        
    }
    
    public init(filter: UserFilterModel?, searchOptions: String?, pageSize: Int?, pageNumber: Int?) {
        self.filter = filter
        self.searchOptions = searchOptions
        self.pageSize = pageSize
        self.pageNumber = pageNumber
    }
    
    mutating func mapping(map: Map) {
        filter <- map["filter"]
        searchOptions <- map["searchOptions"]
        pageSize <- map["pageSize"]
        pageNumber <- map["pageNumber"]
    }
    
}
