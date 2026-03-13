//
//  CategoryModel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//

import Foundation


public struct CategoryModel {
    public var id: String
    public var name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    public init(){
        self.id = ""
        self.name = ""
    }
  
}

public struct SubCategoryModel: Hashable {
    public var id: String
    public var name: String
    public var category: CategoryModel
    
    public init(id: String, name: String, category: CategoryModel) {
        self.id = id
        self.name = name
        self.category = category
    }
    
    // Implementing Hashable and Equatable conformance
    public func hash(into hasher: inout Hasher) {
         hasher.combine(id)
         hasher.combine(name)
     }
     
     static public func == (lhs: SubCategoryModel, rhs: SubCategoryModel) -> Bool {
         return lhs.id == rhs.id && lhs.name == rhs.name
     }
}
