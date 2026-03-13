//
//  SharedEndpoint.swift
//  SharedResources
//
//  Created by Eslam on 08/03/2026.
//

import Foundation

public protocol SharedEndpoint {
    var service: SharedEndpointService {get set}
    var urlPrefix: String {get set}
    var method: EndpointMethod {get set}
    var auth: AuthorizationHandler {get set}
    var parameters: [String: Any] {get set}
    var encoding: EndpointEncoding {get set}
    var headers: [String: String] {get set}
    var multipart: [MultiPartModel] {get }
}

public enum EndpointEncoding {
    case json
    case query
}

public enum EndpointMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}
public struct SharedEndpointService {
    public var url: String

    public init(url: String) {
        self.url = url
    }

    public static var baseUrl: String {
        return cerqel_Environment.Api_Base_URL + "gw/"
    }
}

// MARK: - SharedResources Default Endpoints
extension SharedEndpointService {

    public static var survey: SharedEndpointService {
        .init(url: "\(baseUrl)selfservices/Api/BasicSurveys/submit")
    }

    public static var getUsers: SharedEndpointService {
        .init(url: "\(baseUrl)api/Users/GetAll")
    }

    public static var pin: SharedEndpointService {
        .init(url: "\(baseUrl)DocumentLibrary/api/Files/pin/")
    }

    public static var approvalCycleAfterSubmission: SharedEndpointService {
        .init(url: "\(baseUrl)api/Tasks/v2/GetApprovalHistory")
    }

    public static var requests: SharedEndpointService {
        let getAllPagedRequests =
        cerqel_Environment.isPreDev
        ? "api/Request/v2/GetAllPaged"
        : "selfservices/api/Request/GetAllPaged"
        return .init(url: "\(baseUrl)\(getAllPagedRequests)")
    }

    public static var excuteAction: SharedEndpointService {
        let executeAction =
        cerqel_Environment.isPreDev
        ? "selfServicesV2/Api/Tasks/ExecuteAction"
        : "selfservices/Api/Tasks/ExecuteAction"
        return .init(url: "\(baseUrl)\(executeAction)")
    }

    public static var SendBackRecipients: SharedEndpointService {
        let retrieveSendbackRecipientsEndPoint =
        cerqel_Environment.isPreDev
        ? "Api/Request/v2/RetrieveSendbackRecipients"
        : "selfservicesv2/Api/Request/RetrieveSendbackRecipients"
        return .init(url: "\(baseUrl)\(retrieveSendbackRecipientsEndPoint)")
    }

    public static var categories: SharedEndpointService {
        .init(url: "\(baseUrl)DocumentLibrary/api/Lookups/Categories")
    }
}

extension SharedEndpoint {
    public var multipart: [MultiPartModel] {
        return []
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

