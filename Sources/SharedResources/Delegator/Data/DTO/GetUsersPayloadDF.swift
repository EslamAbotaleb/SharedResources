//
//  GetUsersPayloadDF.swift
//  CERQEL
//
//  Created by Youxel on 13/05/2024.
//  Copyright © 2024 Youxel. All rights reserved.
//

import Foundation

struct GetUsersPayload : Codable, Mappable {
    var filter : UserFilterModelDF?
    var searchOptions : String?
    var pageSize : Int?
    var pageNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case filter = "filter"
        case searchOptions = "searchOptions"
        case pageSize = "pageSize"
        case pageNumber = "pageNumber"
    }
    
    init?(map: Map) {
        
    }
    init() {
        
    }
    
    init(filter: UserFilterModelDF?, searchOptions: String?, pageSize: Int?, pageNumber: Int?) {
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
