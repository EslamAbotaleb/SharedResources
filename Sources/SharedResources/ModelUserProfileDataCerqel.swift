//
//  ModelUserProfileDataCerqel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


public struct ModelUserProfileDataCerqel: Codable {
    // new structure
    public let id : String?
    public let name : String?
    public let jobTitle : String?
    public let mail : String?
    public let departmentName : String?
    public let phone : String?
    public let photo : String?
    public let managerName: String?

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case jobTitle = "jobTitle"
        case mail = "email"
        case departmentName = "departmentName"
        case phone = "phone"
        case photo = "photo"
        case managerName
    }
}
