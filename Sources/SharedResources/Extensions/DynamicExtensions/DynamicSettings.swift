//
//  DynamicSettings.swift
//  CERQEL
//
//  Created by hassan elshaer on 17/09/2023.
//  Copyright © 2023 Youxel. All rights reserved.
//

import UIKit
internal import MOLH
import Network
internal import Toast
internal import JGProgressHUD

public var appsDicCerqel: [String : String] = [
    "facebook" : "fb://" ,
    "kiloloco" : "kilolocossss://",
    "instagram" : "instagram://",
    "twitter" : "twitter://",
    "microsoft-outlook" : "ms-outlook://",
    "microsoft-teams" : "msteams://",
    "microsoft-authenticator" : "msauth://",
    "figma" : "figma://",
    "gmail" : "googlegmail://",
    "youtube" : "youtube://",
]

public func openAttachment(withURLString: String) {
    
    guard let url = URL(string: withURLString) else { return }
    UIApplication.shared.open(url)
}

public let dateFormatterLocale_ar = Locale(identifier: "ar")
public let dateFormatterLocal_en_US = Locale(identifier: "en_US")
public let hijriCalendar = Calendar.init(identifier: .islamicUmmAlQura)
public let hijriCalendarType: Calendar.Identifier = .islamicUmmAlQura

public func delay(seconds: Double, completion: @escaping () -> ()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}

public func getTimeDifference(dt: Date, includeDays: Bool, includeDaysIfCurrentIsLess: Bool)-> (String?, String?, String?, String?){
    var cal = Calendar.current
    cal.timeZone = timeZone_UTC
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
                return ( nil, nil, nil, String(d - cd) + " " + "day".localized)
            }else{
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

public func changeLanguageCerqel(){
    if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }else{
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
    }

}


public func findDateDiffCerqel(time1Str: String, time2Str: String, timeFormat: String) -> String {
    let timeformatter = DateFormatter()
    timeformatter.dateFormat = timeFormat

    guard let time1 = timeformatter.date(from: time1Str),
          let time2 = timeformatter.date(from: time2Str) else { return "" }

    //You can directly use from here if you have two dates

    let interval = time2.timeIntervalSince(time1)
    let hour = interval / 3600;
    let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
    let intervalInt = Int(interval)
    return "\(Int(hour)) Hours \(Int(minute)) Minutes"
}

public func delayCerqel(seconds: Double, completion: @escaping () -> ()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)

    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}


public func setNavUserImageBtnCerqel(btn: UIBarButtonItem){

}



public func openAttachmentCerqel(withURLString: String) {
    guard let url = URL(string: withURLString) else { return }
    UIApplication.shared.open(url)
}

public func openAppFromCerqelAppCerqel(appStoreURL: String) -> Bool {
    for key in appsDicCerqel.keys {
        if appStoreURL.contains(key) {
            return openAppCerqel(scheme: appsDicCerqel[key], appStoreURL: appStoreURL)
        }
    }
    guard verifyUrlCerqel(urlString: appStoreURL) else { return false }
    return openAppCerqel(scheme: appStoreURL, appStoreURL: appStoreURL)
}

public func verifyUrlCerqel(urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}

public func openAppCerqel(scheme: String?, appStoreURL: String) -> Bool {
    let url = URL(string: scheme ?? "")!
    let application = UIApplication.shared
    // Check if the App is installed
    if application.canOpenURL(url) {
        application.open(url)
    } else {
        guard verifyUrlCerqel(urlString: appStoreURL) else { return false }
        application.open(URL(string: appStoreURL)!)
    }
    return verifyUrlCerqel(urlString: appStoreURL)
}


public func convertDateStringToAnotherFormatCerqel(oldFormat: String, newFormat: String, dateString: String) -> String {
    let myDateString = dateString

    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = oldFormat
    dateFormatter.timeZone = currentTimeZoneCerqel //TimeZone.current//
    dateFormatter.locale = dateFormatterLocal_en_USCerqel
    let myDate = dateFormatter.date(from: myDateString)!

    dateFormatter.dateFormat = newFormat
    let newDate = dateFormatter.string(from: myDate)

    return newDate
}

public func compareBetweenTwoDatesCerqel(start: String, end: String) -> Bool {

    let formatter = DateFormatter()
    formatter.dateFormat = "dd/mm/yyyy"
    formatter.timeZone = currentTimeZoneCerqel //TimeZone.current//
    formatter.locale = dateFormatterLocal_en_USCerqel
    let firstDate = formatter.date(from: start)
    let secondDate = formatter.date(from: end)

    if firstDate?.compare(secondDate!) == .orderedAscending {
        print("First Date is smaller then second date")
        return true
    } else {
        return false
    }

}

public func showToastCerqel(parentView: UIViewController, msg: String){

    var style = ToastStyle()
    style.imageSize = CGSize(width: 20, height: 20)
    style.messageFont = UIFont.bodyLMedium()
    style.messageColor = .white
    style.backgroundColor = .black
    style.fadeDuration = 3

    parentView.view.makeToast(msg, point: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - 140), title: nil, image: nil, style: style, completion: nil)
}


public func showNoConnectionPopupCerqel(parentView: UIViewController){
}

public func checkReachabilityCerqel(){
    DispatchQueue.main.async {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Connected")
                DispatchQueue.main.async {
                    UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
                }

            } else {
                print("Disconnected")
                DispatchQueue.main.async {
                    if let v = UIApplication.shared.keyWindow?.rootViewController{
                        showNoConnectionPopupCerqel(parentView: v)
                        UIApplication.shared.keyWindow!.isUserInteractionEnabled = false

                    }
                }
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)


    }

}

public func sendAnEmailCerqel(email: String){
    if let url = URL(string: "mailto:\(email)") {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

}


public func getDatesDifferenceInDaysCerqel(fromDate: Date?, toDate: Date?) -> Int?{

    guard let fromDate = fromDate, let toDate = toDate else{
        return nil
    }
    var cal = Calendar.current
    cal.timeZone = currentTimeZoneCerqel

    let date1 = cal.startOfDay(for: fromDate)
    let date2 = cal.startOfDay(for: toDate)

    let components = cal.dateComponents([.day, .month, .year], from: date1, to: date2)

    print("WE GOT DIFF = \(components.day) DAYS, \(components.month) MON, \(components.year) YEAR")

    let days = components.day ?? 0
    let month = ((components.month ?? 0) * 30)
    let year = ((components.year ?? 0) * 12 * 30)

    let allDays = days + month + year

    return allDays + 1
}
