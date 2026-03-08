//
//  ColorCustomizationModelCerqel.swift
//  SharedResources
//
//  Created by Eslam on 08/03/2026.
//

import Foundation

public struct ColorCustomizationModelCerqel: Codable {
    
    var red: Double?
    var green: Double?
    var blue: Double?
    var alpha: Double?
    
    enum CodingKeys: String, CodingKey {
        case red
        case green
        case blue
        case alpha
    }
}
