//
//  Services.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import UIKit

public class Services {
    
    static public let shared = Services()
    
    /// Get DynamicForm
    /// - Parameters:
    ///   - serviceId: current service to be rendered
    ///   - completion: (serviceName,scheme,error message)
    func getForm(serviceId: String, isEdit: Bool, isApproverForm: Bool, completion: @escaping (String?, String?, JSON2?, String?) -> Void) {
        var formResponseKey = "requestForm"
        guard var url = URL(string: "\(cerqel_Environment.Api_Base_URL + UrlBaseEndpoints.selfService.rawValue)SelfServices/RequestService/\(serviceId)") else {
              print("Invalid URL")
              completion(nil, nil, nil, "Invalid URL")
              return
          }

        if isEdit { // for edit request
            url =  URL(string: "\(cerqel_Environment.Api_Base_URL + UrlBaseEndpoints.selfService.rawValue)Request/GetSchemaWithValuesById/\(serviceId)?roleType=1")!

        } else if isApproverForm {
            formResponseKey = "viewForm" // to make the parse of response succeed
            url = URL(string: "\(cerqel_Environment.Api_Base_URL + UrlBaseEndpoints.selfService.rawValue)Tasks/GetById/\(serviceId)?roleType=2")!
        }
                        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = SharedAuthManager.shared.token
        let languageCode = isArabic() ? "Ar" : "En"
        
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer \(token)",
            "LanguageCode": languageCode,
            "Platform": "IOS",
            "Content-Type": "application/json",
            "charset": "utf-8",
            "TenantId": SharedAuthManager.shared.tenant?.tenantId ?? ""
        ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error retrieving form data: \(error)")
                completion(nil, nil, nil, error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response status code")
                completion(nil, nil, nil, "Unexpected response status code")
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil, nil, nil, "No data received")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let result = json["result"] as? [String: Any],
                      let data = result["data"] as? [String: Any] else {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = json as? [String: Any], let message = jsonDict["message"] as? String {
                        print(message)
                        completion(nil, nil, nil, message)
                    } else {
                        completion(nil, nil, nil, nil)
                    }
                    return
                }
                
                if let requestForm = data[formResponseKey] as? [String: Any],
                   let schema = requestForm["schema"] as? JSON2 {
                    let formVersionId: String? = data["formVersionId"] as? String
                    let serviceName: String? = data["serviceName"] as? String
                    
                    // Convert schema to camelCase
                    let camelCaseSchema = self.convertKeysToCamelCase(schema) as? JSON2
                    
                    // Pass the camelCased schema to completion
                    completion(serviceName, formVersionId, camelCaseSchema, nil)
                } else if let viewForm = data["viewForm"] as? [String: Any],
                          let schema = viewForm["schema"] as? JSON2 {
                    let formVersionId: String? = data["formVersion"] as? String
                    let serviceName: String? = data["serviceName"] as? String
                    
                    // Convert schema to camelCase
                    let camelCaseSchema = self.convertKeysToCamelCase(schema) as? JSON2
                    
                    // Pass the camelCased schema to completion
                    completion(serviceName, formVersionId, camelCaseSchema, nil)
                } else {
                    completion(nil, nil, nil, "Invalid form structure")
                }
            } catch let error {
                print("Error parsing JSON: \(error)")
                completion(nil, nil, nil, error.localizedDescription)
            }
        }
        
        task.resume()
    }

    func getRequestDetailsForm(id: String, isRequest: Bool, completion: @escaping (String?, String?, JSON2?, String?) -> Void) {
        
        guard var url = URL(string: "\(cerqel_Environment.Api_Base_URL + UrlBaseEndpoints.selfService.rawValue)Tasks/GetById/\(id)") else {
            print("Invalid URL")
            completion(nil, nil, nil, "Invalid URL")
            return
        }
        
        if isRequest {
            url = URL(string: "\(cerqel_Environment.Api_Base_URL + UrlBaseEndpoints.selfService.rawValue)Request/GetById/\(id)")!
        }
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = SharedAuthManager.shared.token
        let languageCode = isArabic() ? "Ar" : "En"
        
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer \(token)",
            "LanguageCode": languageCode,
            "Platform": "IOS",
            "Content-Type": "application/json",
            "charset": "utf-8",
            "TenantId": SharedAuthManager.shared.tenant?.tenantId ?? ""
        ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error retrieving form data: \(error)")
                completion(nil, nil, nil, error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response status code")
                completion(nil, nil, nil, "Unexpected response status code")
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil, nil, nil, "No data received")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let result = json["result"] as? [String: Any],
                      let data = result["data"] as? [String: Any] else {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = json as? [String: Any], let message = jsonDict["message"] as? String {
                        print(message)
                        completion(nil, nil, nil, message)
                    } else {
                        completion(nil, nil, nil, nil)
                    }
                    return
                }
                
                if let requestForm = data as? JSON2 {
                    let formVersionId: String? = data["formVersionId"] as? String
                    let serviceName: String? = data["serviceName"] as? String
                    
                    // Convert schema to camelCase
                    let camelCaseSchema = self.convertKeysToCamelCase(requestForm) as? JSON2
                    
                    // Pass the camelCased schema to completion
                    completion(serviceName, formVersionId, camelCaseSchema, nil)
                } else {
                    completion(nil, nil, nil, "Invalid form structure")
                }
            } catch let error {
                print("Error parsing JSON: \(error)")
                completion(nil, nil, nil, error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    
    func convertPascalCaseToCamelCase(_ key: String) -> String {
        guard !key.isEmpty else { return key }
        
        let firstChar = key.prefix(1).lowercased()
        let otherChars = key.dropFirst()
        return "\(firstChar)\(otherChars)"
    }
    
    func convertKeysToCamelCase(_ json: Any) -> Any {
        if var dict = json as? [String: Any] {
            var result = [String: Any]()
            for (key, value) in dict {
                let camelCaseKey = convertPascalCaseToCamelCase(key)
                result[camelCaseKey] = convertKeysToCamelCase(value)
            }
            return result
        } else if var array = json as? [Any] {
            for (index, value) in array.enumerated() {
                array[index] = convertKeysToCamelCase(value)
            }
            return array
        } else {
            return json
        }
    }
    
    
    /// Get DynamicActions in task details
    /// - Parameters:
    ///   - actionId: action id that will render a dynamicForm
    ///   - completion: (serviceName,scheme,error message)
    func getActionForm(actionId: String, completion: @escaping (String?,JSON2?, String?) -> Void) {
        guard let url = URL(string: "\(cerqel_Environment.Api_Base_URL)NewFormBuilder/api/Forms/GetSchema") else {
            print("Invalid URL")
            completion(nil,nil, "Invalid URL")
            return
        }
        
        let json: [String: Any] = ["formId": actionId]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let token = SharedAuthManager.shared.token
        let languageCode = isArabic() ? "Ar" : "En"
        
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer \(token)",
            "LanguageCode": languageCode,
            "Platform":"IOS",
            "Content-Type":"application/json",
            "charset": "utf-8",
            "TenantId": SharedAuthManager.shared.tenant?.tenantId ?? ""
        ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error retrieving form data: \(error)")
                completion(nil,nil, error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response status code")
                completion(nil,nil, "Unexpected response status code")
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil,nil, "No data received")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let data = json["data"] as? [String: Any],
                      let schema = data["schema"] as? JSON2 else {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = json as? [String: Any], let message = jsonDict["message"] as? String {
                        print(message)
                        completion(nil,nil, message)
                    }else{
                        completion(nil,nil, nil)
                    }
                    return
                }
                
                completion("",schema, nil)
            } catch let error {
                print("Error parsing JSON: \(error)")
                completion(nil,nil, error.localizedDescription)
            }
        }
        
        task.resume()
    }
}

public struct Utilities {
    static public func storyboard(withName name: String, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: bundle)
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
}
