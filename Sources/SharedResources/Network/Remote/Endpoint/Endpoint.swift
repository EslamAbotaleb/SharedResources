//
//  Endpoint.swift
//  SharedResources
//
//  Created by Eslam on 08/03/2026.
//

import Foundation

protocol Endpoint {
    var service: EndpointService {get set}
    var urlPrefix: String {get set}
    // var endpointVersion: Versions {get set}
    var method: EndpointMethod {get set}
    var auth: AuthorizationHandler {get set}
    var parameters: [String: Any] {get set}
    var encoding: EndpointEncoding {get set}
    var headers: [String: String] {get set}
    var multipart: [MultiPartModel] {get }
}

enum EndpointEncoding {
    case json
    case query
}

enum EndpointMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}

public enum EndpointService {

    case survey
    case getUsers
    case pin
    case approvalCycleAfterSubmission
    case requests
    case excuteAction
    case SendBackRecipients
    case categories
    
    var url: String {
        switch self {
        case .survey:
            return "\(baseUrl)selfservices/Api/BasicSurveys/submit"
        case .getUsers:
            return "\(baseUrl)api/Users/GetAll"
        case .pin:
            return "\(baseUrl)DocumentLibrary/api/Files/pin/"
        case .approvalCycleAfterSubmission:
            return "\(baseUrl)api/Tasks/v2/GetApprovalHistory"
        case .requests:
            let getAllPagedRequests =
            cerqel_Environment.isPreDev
            ? "api/Request/v2/GetAllPaged"
            : "selfservices/api/Request/GetAllPaged"
            return "\(baseUrl)\(getAllPagedRequests)"
        case .excuteAction:
            let executeAction =
            cerqel_Environment.isPreDev
            ? "selfServicesV2/Api/Tasks/ExecuteAction"
            : "selfservices/Api/Tasks/ExecuteAction"
            return "\(baseUrl)\(executeAction)"
        case .SendBackRecipients:
            let retrieveSendbackRecipientsEndPoint =
            cerqel_Environment.isPreDev
            ? "Api/Request/v2/RetrieveSendbackRecipients"
            : "selfservicesv2/Api/Request/RetrieveSendbackRecipients"
            return "\(baseUrl)\(retrieveSendbackRecipientsEndPoint)"
        case .categories:
            return "\(baseUrl)DocumentLibrary/api/Lookups/Categories"
        }
    }
}

extension Endpoint {
    public var multipart: [MultiPartModel] {
        return []
    }

}

extension EndpointService {

    public var baseUrl: String{
        return cerqel_Environment.Api_Base_URL + "gw/"
    }
}

public func generateURLWithParams(params: [String: Any]?) -> String {
    if (params != nil && !(params!.isEmpty)) {
        var api = "?"

        params?.forEach { key, value in
            if let val = value as? CustomStringConvertible {
                api += "\(key)=\(val)&"
            }
        }

        if api.contains("&") {
            api = String(api.dropLast())
        }

        return api
    }
    else {
        return ""
    }
}

public func convertModelToDictionary<T>(model: T) -> [String: Any] {
    let mirror = Mirror(reflecting: model)
    var dictionary = [String: Any]()
    
    for case let (label?, value) in mirror.children {
        dictionary[label] = value
    }

    return dictionary
}

