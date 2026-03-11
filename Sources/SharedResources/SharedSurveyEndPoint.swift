//
//  SurveyEndPoint.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//

import Foundation

public struct SurveyEndPoint: SharedEndpoint {
    public var urlPrefix: String = ""
    public var service: SharedEndpointService = .survey
    public var method: EndpointMethod = .post
    public var encoding: EndpointEncoding = .json
    public var auth: AuthorizationHandler = SharedUserAuthoriationHandler()
    public var parameters: [String: Any] = [:]
    public var headers: [String: String] = [:]

    public init(surveyPayload: SurveyPayload) {
        parameters = surveyPayload.asDictionary()
    }
}

public struct SurveyPayload: Codable {
    public var serviceId: String?
    public var rating: Int?
    public var comment: String?
    
    public init() {}
    public init(serviceId: String? = nil, rating: Int? = nil, comment: String? = nil) {
        self.serviceId = serviceId
        self.rating = rating
        self.comment = comment
    }
}
