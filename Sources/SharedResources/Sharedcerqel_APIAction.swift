//
//  Sharedcerqel_APIAction.swift
//  CERQEL
//
//  Created by iSlam on 10/11/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import Foundation
internal import Alamofire

enum cerqel_URLType{
    case selfService // dynamic form
    case userManager // dynamic form
    case fileManager // dynamic form
    case base
    case none
}

enum UrlBaseEndpoints: String {
    case selfService = "gw/selfservices/api/"
    case userManager = "gw/usermanager/api/"
    case fileManager = "gw/Storage/api/"
}

protocol Sharedcerqel_APIAction: URLRequestConvertible, Sendable {
    var method: HTTPMethod { get }
    var path: String { get }
    var actionParameters: [String: Any] { get }
    var baseURL: String { get }
    var authHeader: [String: String] { get }
    var encoding: ParameterEncoding { get }
    var isMock: Bool { get }
    var urlType: cerqel_URLType { get }
    var basicAction: Sharedcerqel_BasicAction { get }
}

extension Sharedcerqel_APIAction {
    public var actionParameters: [String : Any] {
        return [:]
    }
    public var authHeader: [String : String] {
        return  [
            "device-type":"ios",
            "Content-Type" :"application/json; charset=utf-8"
        ]

    }
    
   public var baseURL: String {
        if isMock{
            switch basicAction {
            case .requestDetails(_):
                return SharedAuthManager.shared.newSubmissionRetreiveEnabled ?  "https://demo2590693.mockable.io/requestDetails" /* new structure */ : "https://demo2590693.mockable.io/requestDetails" /* old structure */
    
            case .taskDetails(_):
                return SharedAuthManager.shared.newSubmissionRetreiveEnabled ? "https://demo2590693.mockable.io/requestDetails" /* new structure */ : "https://demo2590693.mockable.io/requestDetails" /* old structure */
            default:
                return ""
            }
        }
        
        switch urlType {
       
        case .selfService:
            return cerqel_Environment.Api_Base_URL + UrlBaseEndpoints.selfService.rawValue
        case .userManager:
            return cerqel_Environment.Api_Base_URL + UrlBaseEndpoints.userManager.rawValue
        case .fileManager:
            return cerqel_Environment.Api_Base_URL + UrlBaseEndpoints.fileManager.rawValue
        case .none:
            return ""

        default:
            return cerqel_Environment.Api_Base_URL

        }
    }
    var isMock: Bool{
        return false
    }
    
}

extension Sharedcerqel_APIAction {
    
    public func asURLRequest() throws -> URLRequest {
        let urlString = baseURL.appending(path)
        let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: encoded ?? "")
            
        let originalRequest = try URLRequest(url: url!,
                                             method: method,
                                             headers: HTTPHeaders(authHeader))
        let encodedRequest = try encoding.encode(originalRequest,
                                                 with: actionParameters)
        
        print("actionParameters")
        print(actionParameters)
        print("httpBodyhttpBody")
        print(encodedRequest.httpBody?.cerqel_prettyPrintedJSONString)
        print("http method")
        print(encodedRequest.httpMethod)
        print(baseURL.appending(path))
        
        return encodedRequest
    }
}

extension Data {
    var cerqel_prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
