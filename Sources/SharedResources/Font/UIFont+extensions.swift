//
//  UIFont+extensions.swift
//  SharedResources
//
//  Created by Eslam on 08/03/2026.
//

import UIKit
import CoreText
import CoreGraphics

extension UIFont {
    
    /// Call this method once during app initialization to register all custom fonts
    public static func registerCustomFonts() {
        let fontNames = [
            "SST Arabic Bold",
            "SST Arabic Light",
            "SST Arabic Medium",
            "SST Arabic Roman",
            "Poppins-Regular",
            "Poppins-SemiBold",
            "Poppins-Medium"
        ]
        
        for fontName in fontNames {
            // font extensions
            for ext in ["ttf", "otf"] {
                if let fontURL = Bundle.module.url(forResource: fontName, withExtension: ext, subdirectory: "Fonts") {
                    registerFont(from: fontURL)
                    break
                }
            }
        }
    }
    
    private static func registerFont(from url: URL) {
        guard let fontDataProvider = CGDataProvider(url: url as CFURL),
              let font = CGFont(fontDataProvider) else {
            print("⚠️ Failed to load font from: \(url.lastPathComponent)")
            return
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            if let error = error?.takeRetainedValue() {
                print("⚠️ Error registering font: \(error)")
            }
        } else {
            print("✅ Successfully registered font: \(url.lastPathComponent)")
        }
    }
    
    public static func SST_Arabic_Bold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SST Arabic Bold", size: ofSize) ?? UIFont.boldSystemFont(ofSize: ofSize)
    }
    
    public static func SST_Arabic_Light(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SST Arabic Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
    
    public static func SST_Arabic_Medium(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SST Arabic Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
    
    public static func SST_Arabic_Roman(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SST Arabic Roman", size: ofSize) ?? UIFont.italicSystemFont(ofSize: ofSize)
    }
    
    public static func heading1(ofSize: CGFloat = 33.0) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
    
    public static func heading2(ofSize: CGFloat = 30.0) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: .semibold)
    }
    
    public static func heading3(ofSize: CGFloat = 24.0) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: .semibold)
    }
    
    public static func heading4(ofSize: CGFloat = 18.0) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: .medium)
    }
    
    public static func heading5(ofSize: CGFloat = 14.0) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: .semibold)
    }
}
