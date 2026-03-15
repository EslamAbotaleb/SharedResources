//
//  Services.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//

import UIKit

public struct Utilities {
    static public func deviceIsIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    static public func handleNavBarAppearance(vc: UIViewController, tintColor: UIColor, shadowColor: UIColor? = .clear) {
        
        vc.navigationController?.navigationBar.isHidden = false
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        vc.tabBarController?.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        vc.navigationController?.navigationBar.prefersLargeTitles = false
        vc.tabBarController?.navigationController?.navigationBar.barTintColor = .white//tintColor
        vc.tabBarController?.navigationController?.navigationBar.tintColor = .white
        
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = attributes
            appearance.backgroundColor = tintColor
            if shadowColor != nil {
                appearance.shadowColor = shadowColor
            }
            vc.tabBarController?.navigationController?.navigationBar.standardAppearance = appearance
            vc.tabBarController?.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    
    static public func storyboard(withName name: String, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    static public func mainStoryBoard() -> UIStoryboard {
        return Utilities.storyboard(withName: "CheckMain")
    }
    
    static public func mainiPadStoryBoard() -> UIStoryboard {
        return Utilities.storyboard(withName: "MainiPad")
    }
    
    static public func instantiateVCWithId(_ id: String) -> UIViewController {
        if Utilities.deviceIsIpad() {
            return Utilities.mainiPadStoryBoard().instantiateViewController(withIdentifier: id)
        } else {
            return Utilities.mainStoryBoard().instantiateViewController(withIdentifier: id)
        }
    }
    
    static public func screedHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static public func screedWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    
    static public func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    static public func saveString(_ str: String, toFile: String){
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(toFile)
            
                //writing
            do {
                try str.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
    }
    
    static public func readString(fromFile: String) -> String? {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(fromFile)
                //reading
            do {
                return try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                
            }
        }
        
        return nil
    }
    
    static public func saveJSON(_ json: Any, toFile: String){
        if FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first != nil {
            var str: String?
            
            do {
                var data1: Data = Data()
                if let jsonObj = json as? JSON2 {
                    data1 =  try JSONSerialization.data(withJSONObject: jsonObj, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                } else if let jsonArray = json as? JSONArray {
                    data1 =  try JSONSerialization.data(withJSONObject: jsonArray, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                    
                } else {
                }
                
                str = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            }
            catch {
            }
            if str == nil {
            }else{
                Utilities.saveString(str!, toFile: toFile)
            }
        }
    }
    
    
    static func readJSON(fromFile: String) -> JSON2? {
        
        let str = Utilities.readString(fromFile: fromFile)
        if str == nil {
        }else{
            let data = str!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON2 {
                    return json
                }else{
                }
            } catch let error as NSError {
            }
        }
        return nil
    }
    
    
    static public func readJSONArray(fromFile: String) -> JSONArray? {
        
        let str = Utilities.readString(fromFile: fromFile)
        if str == nil {
        }else{
            let data = str!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSONArray {
                    return json
                }else{
                }
            } catch let error as NSError {
            }
        }
        return nil
    }
    
    static public func getAppVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    static public func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    static public func deviceIs_iPhone5() -> Bool{
        switch UIScreen.main.nativeBounds.height {
            case 1136:
                return true
                break
            default:
                return false
        }
    }
    
    static public func getOsVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    static public func instantiateType(fromString string: String) -> AnyClass? {
        guard let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            return nil
        }
        
        return NSClassFromString("\(namespace).\(string)")
    }
    
    static public func suffixNumber(number: NSNumber) -> String {
        
        var num:Double = number.doubleValue
        let sign = ((num < 0) ? "-" : "" )
        
        num = fabs(num);
        
        if (num < 1000.0) {
            let intNum = Int(num)
            return "\(sign)\(intNum)"
        }
        
        let exp:Int = Int(log10(num) / 3.0 ); //log10(1000));
        
        var units:[String]
        if isArabic() {
            units  = ["أ",
                      "م",
                      "مل",
                      "ت",
                      "كواد",
                      "كوينت"];
        } else {
            units  = ["K","M","B","TR","Quad","Quint"];
        }
        
        let roundedNum:Double = round(10 * num / pow(1000.0,Double(exp))) / 10
        let roundedInt = Int(roundedNum)
        return "\(sign)\(roundedInt)\(units[exp-1])"
    }
}
