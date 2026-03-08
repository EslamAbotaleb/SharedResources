//
//  SettingsDynamicForm.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//


import UIKit
internal import MOLH
//import PopupDialog
import Network
internal import Toast
internal import JGProgressHUD
internal import Kingfisher
import Photos
import UIKit

public let globalHeaders = [
    "Authorization": "Bearer " + AuthManagerDynamicForm.shared.token,
    "TenantId": AuthManagerDynamicForm.shared.tenant?.tenantId ?? "",
    "LanguageCode": isArabic() ? "Ar" : "En",
    "Platform":"IOS",
    "Content-Type":"application/json",
    "charset" : "utf-8",
    "TimeZone": TimeZone.current.identifier,
]

internal let modifier = AnyModifier { request in
    var r = request

    let token = AuthManagerDynamicForm.shared.token
    r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    return r
}

public let FF_New_Form_DesignCerqel = true
public let timeZone_UTC = TimeZone(abbreviation: "UTC") ?? TimeZone.current

public let dateFormatterLocale_arCerqel = Locale(identifier: "ar")
public let dateFormatterLocal_en_USCerqel = Locale(identifier: "en_US")
public let utc_TimeZoneCerqel = TimeZone(abbreviation: "UTC")
public let currentTimeZoneCerqel = TimeZone.current
public let favImageForDetails = UIImage(named: "fav-Undimmed")
public let notFavImageForDetails = UIImage(named: "fav-dimmed")
public let FF_New_Form_Design = true
public let favStar = UIImage(named: "starfilled")
public let unFavStar = UIImage(named: "starunfill")
public let tempServiceImg = UIImage(named: "service1")

public func hexStringToUIColor(hex: String) -> UIColor {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
    }

    if cString.count == 6 {
        cString = cString + "FF"
    } else if cString.count != 8 {
        return UIColor.gray
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    let red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
    let green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
    let blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
    let alpha = CGFloat(rgbValue & 0x000000FF) / 255.0 // Keep as is

    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

public func getTimeDifferenceCerqel(dt: Date, includeDays: Bool, includeDaysIfCurrentIsLess: Bool)-> (String?, String?, String?, String?){
    var cal = Calendar.current
    cal.timeZone = currentTimeZoneCerqel
    let comps = cal.dateComponents([.hour, .minute, .second, .day], from: dt)
    let hours = comps.hour
    let min = comps.minute
    let sec = comps.second
    let days = comps.day

    let currentComps = cal.dateComponents([.hour, .minute, .second, .day], from: Date())
    let currHours = currentComps.hour
    let currMin = currentComps.minute
    let currSec = currentComps.second
    let currDays = currentComps.day


    if includeDays {
        if let d = days, let cd = currDays, (cd - d) > 0{
            if (cd - d) == 1{
                return ( nil, nil, nil, "day ago".localized)
            }else{
                return (nil, nil, nil,String(format: "days ago".localized, "\(cd - d)"))
            }
        }
    }

    if includeDaysIfCurrentIsLess {
        if let d = days, let cd = currDays, (d - cd) >= 0 {
            if (d - cd) == 0 || (d - cd) == 1 {
                //                return ( nil, nil, nil,String(format: "day".localized, "\(d - cd)"))
                return ( nil, nil, nil, String(d - cd) + " " + "day".localized)
            }else{
                //                return (nil, nil, nil,String(format: "days".localized, "\(d - cd)"))
                return ( nil, nil, nil, String(d - cd) + " " + "days".localized)
            }
        }
    }

    if let h = hours, let ch = currHours, (ch - h) > 0{
        if (ch - h) == 1{
            return ("hour ago".localized, nil, nil, nil)
        }
        return (String(format: "hours ago".localized, "\(ch - h)"), nil, nil, nil)
    }else if let m = min, let cm = currMin, (cm - m) > 0{
        if (cm - m) == 1{
            return ("minute ago".localized, nil, nil, nil)
        }
        return (nil, String(format: "minutes ago".localized, "\(cm - m)"), nil, nil)
    }else if let s = sec, let cs = currSec, (cs - s) > 0{
        return (nil, nil, "\(cs - s) \("seconds ago".localized)", nil )
    }else{
        return(nil, nil, nil, nil)
    }

}

public func getCurrentDateCerqel(dateFormat: String) -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.timeZone = currentTimeZoneCerqel //TimeZone.current//
    formatter.locale = dateFormatterLocal_en_USCerqel
    formatter.dateFormat = dateFormat
    let today = formatter.string(from: date)
    return today
}

public func createInitialsImage(name: String, backgroundColor: UIColor, textColor: UIColor, size: CGSize, font: UIFont) -> UIImage? {
    let initials = name.split(separator: " ").compactMap { $0.first }.prefix(2)
    let initialsString = isArabic() ? initials.map { String($0) }.joined(separator: "\u{00A0}") : initials.map { String($0) }.joined(separator: "")

    // Begin drawing the image
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }

    // Set the background color
    context.setFillColor(backgroundColor.cgColor)
    context.fill(CGRect(origin: .zero, size: size))

    // Define the attributes
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: textColor
    ]

    // Calculate the size of the text to center it properly
    let textSize = initialsString.size(withAttributes: attributes)

    // Calculate the position to center the text vertically and horizontally
    let textX = (size.width - textSize.width) / 2
    let textY = (size.height - textSize.height) / 2

    // Draw the initials in the center of the image
    initialsString.draw(
        in: CGRect(x: textX, y: textY, width: textSize.width, height: textSize.height),
        withAttributes: attributes
    )

    // Extract the image
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return image
}

public func handleImageWithKFCerqel(
    imgUrl: String?,
    img: UIImageView,
    name: String?,
    color: UIColor,
    textColor: UIColor,
    withDummyImg: Bool = false,
    initialDummyImageName: String = "User"
) {
    var placeHolder: UIImage?

    // Create the placeholder image with initials if name is provided
    if let nameStr = name, !nameStr.isEmpty {
        let initialsImage = createInitialsImage(
            name: nameStr,
            backgroundColor: color,
            textColor: textColor,
            size: CGSize(width: 40, height: 40),
            font: UIFont.boldSystemFont(ofSize: 18)
        )

        placeHolder = initialsImage
    }

    // If dummy image is required, use the specified dummy image name
    if withDummyImg {
        placeHolder = UIImage(named: initialDummyImageName)
    }

    img.loadUserWebImage(imageUrl: imgUrl ?? "", placeHolderImage: placeHolder  ?? UIImage())
}


public func textToImageCerqel(drawText text: String, inImage image: UIImage, atPoint point: CGPoint, textSize: CGSize,textColor:UIColor) -> UIImage {
    // let textColor = UIColor.white
    let textFont = UIFont.SST_Arabic_Medium(ofSize: 18)

    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

    let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: textColor,
    ] as [NSAttributedString.Key : Any]

    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    print("origin: \(CGPoint.zero)")

    let rect = CGRect(origin: point, size: textSize)
    text.draw(in: rect, withAttributes: textFontAttributes)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}

public func makeACallCerqel(num: String){
    guard let url = URL(string: "tel://\(num)"),
          UIApplication.shared.canOpenURL(url) else { return }
    if #available(iOS 10, *) {
        UIApplication.shared.open(url)
    } else {
        UIApplication.shared.openURL(url)
    }
}

public func mergeDatesCerqel(usingDateFrom: Date, UsingTimeFrom: Date) -> Date?{
    var cal = Calendar.current
    cal.timeZone = currentTimeZoneCerqel
    var dateComps = cal.dateComponents([.day, .month, .year, .hour , .minute], from: usingDateFrom)
    let timeComps = cal.dateComponents([.hour, .minute], from: UsingTimeFrom)

    dateComps.hour = timeComps.hour
    dateComps.minute = timeComps.minute

    let newDate = cal.date(from: dateComps)
    return newDate

}

@MainActor
public func handleImageWithKF(imgUrl:String? ,img:UIImageView ,name:String?, color: UIColor, textColor: UIColor){
    let imgTo = UIImage(color: color)
    let to = imgTo?.resized(to: CGSize(width: 40, height: 40))
    var placeHolder: UIImage?
    var textSize: CGSize?
    if let nameStr = name?.initialsFromString(string: name ?? "") {
        textSize = CGSize(width: (nameStr.width(withConstrainedHeight: 24, font: UIFont.SST_Arabic_Medium(ofSize: 18))), height: 27)
        placeHolder = textToImage(drawText: nameStr, inImage: to!, atPoint: CGPoint(x: ((40 - (nameStr.width(withConstrainedHeight: 24, font: UIFont.SST_Arabic_Medium(ofSize: 18)))) / 2), y: 9), textSize: textSize!, textColor: textColor)
    }

    img.kf.setImage(with: URL(string: imgUrl ?? ""), placeholder: placeHolder, options:nil, progressBlock: nil,completionHandler: { result in
    })
}

public func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint, textSize: CGSize,textColor:UIColor) -> UIImage {
    // let textColor = UIColor.white
    let textFont = UIFont.SST_Arabic_Medium(ofSize: 18)
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

    let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: textColor,
    ] as [NSAttributedString.Key : Any]

    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    print("origin: \(CGPoint.zero)")

    let rect = CGRect(origin: point, size: textSize)
    text.draw(in: rect, withAttributes: textFontAttributes)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}


