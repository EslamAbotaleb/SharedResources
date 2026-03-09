//
//  GetUsersEndPoint.swift
//  CERQEL
//
//  Created by Youxel on 13/05/2024.
//  Copyright © 2024 Youxel. All rights reserved.
//

import Foundation

public struct GetUsersEndPoint: Endpoint {
   public var urlPrefix: String = ""
   public var service: EndpointService = .getUsers
   public var method: EndpointMethod = .post
   public var encoding: EndpointEncoding = .json
   public var auth: AuthorizationHandler = SharedUserAuthoriationHandler()
   public var parameters: [String: Any] = [:]
   public var headers: [String: String] = [:]

    init(payload: GetUsersPayload) {
        parameters = payload.asDictionary()
   }
}
