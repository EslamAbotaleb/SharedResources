//
//  CerqelFonts.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import SwiftUI

public struct CerqelFonts {
    static public let subtitleLRegular = Font.cerqel(.regular, size: 20.0)
    static public let bodyLSemibold = Font.cerqel(.semibold, size: 16)
    static public let bodyLMedium = Font.cerqel(.medium, size: 16)
    static public let bodyLRegular = Font.cerqel(.regular, size: 16)
    static public let bodyMSemibold = Font.cerqel(.semibold, size: 14)
    static public let bodyMMedium = Font.cerqel(.medium, size: 14)
    static public let bodyMRegular = Font.cerqel(.regular, size: 14)
    static public let bodySSemibold = Font.cerqel(.semibold, size: 12)
    static public let bodySMedium = Font.cerqel(.medium, size: 12)
    static public let bodySRegular = Font.cerqel(.regular, size: 12)
    static public let caption1Semibold = Font.cerqel(.semibold, size: 10)
    static public let caption2Medium = Font.cerqel(.medium, size: 10)
    static public let caption3Regular = Font.cerqel(.regular, size: 10)
    static public let popinsItalic16 = Font.cerqel(.mediumItalic, size: 16)
    static public let popinsItalic14 = Font.cerqel(.mediumItalic, size: 14)
    static public let popinsItalic12 = Font.cerqel(.mediumItalic, size: 12)
    static public let popinsItalic10 = Font.cerqel(.mediumItalic, size: 10)
}

extension Font {
    
    public enum CerqelFont {
        case regular
        case medium
        case semibold
        case mediumItalic
        case custom(String)
        
        public var value: String {
            switch self {
            case .regular:
                return "Poppins-Regular"
            case .medium:
                return "Poppins-Medium"
            case .semibold:
                return "Poppins-Semibold"
            case .mediumItalic:
                return "Poppins-MediumItalic"
            case .custom(let name):
                return name
            }
        }
    }
    
    static public func cerqel(_ type: CerqelFont, size: CGFloat = 14) -> Font {
        return .custom(type.value, size: size)
    }
}
