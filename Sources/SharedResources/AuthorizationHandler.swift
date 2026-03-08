//
//  AuthorizationHandler.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//


import Foundation

public protocol AuthorizationHandler {
    var tokenHeader: [String: String] { get }
    var clientHeader: [String: String] { get }
    var uidHeader: [String: String] { get }
    var faceIdPhone: String { get }
    func setAuthManually(authToken: String)
    func setPhoneForFaceId(phone: String)
    func setClientManually(clientType: String)
    func setUidManually(uid: String)
    func removeAuthManually(authToken: String)
    func removeClientManually(client: String)
    func removeUidManually(uid: String)
}
