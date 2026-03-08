//
//  MyColor.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//

import Foundation
import UIKit

@MainActor public var needed: Bool = false

// MARK:- App Colors
@MainActor public var alertClosed = UIColor(hex: "#737373")
@MainActor public var primaryMain = UIColor(rCerqel: 113, gCerqel: 43, bCerqel: 129, aCerqel: 1)
@MainActor public var primaryLight = UIColor(rCerqel: 254, gCerqel: 248, bCerqel: 255, aCerqel: 1)
@MainActor public var secondaryMain = UIColor(rCerqel: 218, gCerqel: 62, bCerqel: 123, aCerqel: 1)
@MainActor public var secondaryLight = UIColor(rCerqel: 255, gCerqel: 245, bCerqel: 249, aCerqel: 1)
@MainActor public var typographyTitle = UIColor(rCerqel: 35, gCerqel: 41, bCerqel: 47, aCerqel: 1)
@MainActor public var typographySubtitle = UIColor(rCerqel: 85, gCerqel: 86, bCerqel: 94, aCerqel: 1)
@MainActor public var typographyBody = UIColor(rCerqel: 150, gCerqel: 150, bCerqel: 150, aCerqel: 1)
@MainActor public var bg = UIColor(rCerqel: 242, gCerqel: 245, bCerqel: 252, aCerqel: 1)
@MainActor public var bgHeader = UIColor(rCerqel: 255, gCerqel: 255, bCerqel: 255, aCerqel: 1)
@MainActor public var bgTabNavigation = UIColor(rCerqel: 255, gCerqel: 255, bCerqel: 255, aCerqel: 1)
@MainActor public var bgHColor = UIColor(rCerqel: 255, gCerqel: 255, bCerqel: 255, aCerqel: 1)
@MainActor public var alertSuccessColor = UIColor(rCerqel: 27, gCerqel: 153, bCerqel: 139, aCerqel: 1)
@MainActor public var defaultGrayColor = UIColor(rCerqel: 189, gCerqel: 189, bCerqel: 189, aCerqel: 1)
@MainActor public var TypographyLinks = UIColor(rCerqel: 46, gCerqel: 151, bCerqel: 239, aCerqel: 1)
@MainActor public var selectExcellentEmojiColor = UIColor(hexString: "#309620")
@MainActor public var selectGoodEmojiColor = UIColor(hexStringCerqel: "#62DA4E")
@MainActor public var selectFairEmojiColor = UIColor(hexStringCerqel: "#E7BB4B")
@MainActor public var selectBadEmojiColor = UIColor(hexStringCerqel: "#EF5757")
@MainActor public var selectVeryBadEmojiColor = UIColor(hexStringCerqel: "#AE2A2A")
@MainActor public var redButton = UIColor(rCerqel: 201, gCerqel: 56, bCerqel: 56, aCerqel: 1)
@MainActor public var sideMenuBG: UIColor = .white
@MainActor public var sideMenuTextColor: UIColor = .white
@MainActor public var sideMenuColorhighLight: UIColor = .white

public class MyColor {
    public var red: CGFloat = 0.0
    public var green: CGFloat = 0.0
    public var blue: CGFloat = 0.0
    public var alpha: CGFloat = 1.0

    public init() {}
    
    public func setFromAPIResponse(_ response: [String: Any]) {
        if let red = response["red"] as? Double {
            self.red = CGFloat(red)
        }
        if let green = response["green"] as? Double {
            self.green = CGFloat(green)
        }
        if let blue = response["blue"] as? Double {
            self.blue = CGFloat(blue)
        }
        if let alpha = response["alpha"] as? Double {
            self.alpha = CGFloat(alpha)
        }
    }

    public func setFromObject(_ color: ColorCustomizationModelCerqel) {
        if let red = color.red {
            self.red = CGFloat(red)
        }
        if let green = color.green {
            self.green = CGFloat(green)
        }
        if let blue = color.blue {
            self.blue = CGFloat(blue)
        }
        if let alpha = color.alpha {
            self.alpha = CGFloat(alpha)
        }

    }

    public func asUIColor() -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UserDefaults {
    public func setColor(color: UIColor?, forKey key: String) {
        guard let color = color else {
            removeObject(forKey: key)
            return
        }

        let data = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        guard let colorData = data else { return }
        set(colorData, forKey: key)
    }

    public func colorForKey(key: String) -> UIColor? {
        guard let colorData = data(forKey: key) else { return nil }
        let color = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor) ?? .systemBackground
        return color
    }
}
