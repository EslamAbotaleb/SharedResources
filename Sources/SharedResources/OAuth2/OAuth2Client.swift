//
//  OAuth2ClientDynamicForm.swift
//  OAuth2
//
//  Copyright © 2018 Muhammad Bassio. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
/*
import Foundation
import SafariServices
internal import KeychainAccess
internal import Alamofire
internal import MOLH
internal import SwiftyJSON

open class OAuth2ClientDynamicForm {

    /// The OAuth2 client configuration.
    private(set) public var configuration:OAuth2Configuration

    /// The OAuth2 fetched access token.
    private(set) public var token:OAuth2Token?
    public var clientDidFinishLoadingToken:(() -> Void) = {}
    public var clientDidFailLoadingToken:((_ NKError:Error) -> Void) = { error in
    }

    public init(configuration:OAuth2Configuration) {
        self.configuration = configuration
        self.token = nil
        self.loadToken()
    }
    
    private func observeProfileAndNotify() {
        var hasCalled = false
        AuthManagerDynamicForm.shared.profile.bind { [weak self] profile in
            guard let self = self else { return }
            guard !hasCalled, profile != nil else { return }
            hasCalled = true
            NotificationCenter.default.post(name: Notification.Name("tokenRefreshed"), object: nil)
            self.clientDidFinishLoadingToken()
        }
    }
    
    /// Override to implement your own logic in subclass.
    open func loadToken() {
        if self.configuration.clientId != "" {
            let keychain = Keychain(service: "OAuth2Client.\(self.configuration.clientId)")
            do {
                if let accessToken = try keychain.get("accessToken.accessToken"),
                   let type = try keychain.get("accessToken.tokenType"),
                   let refreshToken = try keychain.get("accessToken.refreshToken") {
                    self.token = OAuth2Token()
                    self.token?.accessToken = accessToken
                    self.token?.tokenType = type
                    self.token?.refreshToken = refreshToken
                    if let idToken = try keychain.get("accessToken.idToken") {
                        self.token?.idToken = idToken
                    }
                    if let timeIntervalString = try keychain.get("accessToken.accessTokenExpiry") {
                        if let timeInterval = Double(timeIntervalString) {
                            let accessTokenExpiry = Date(timeIntervalSinceReferenceDate: timeInterval)
                            self.token?.accessTokenExpiry = accessTokenExpiry
                        }
                    }
                }
            }catch {}
        }
    }

    /// Override to implement your own logic in subclass.
    open func saveToken() {
        if self.configuration.clientId != "" {
            let keychain = Keychain(service: "OAuth2Client.\(self.configuration.clientId)")
            if let accessToken = self.token?.accessToken, let type = self.token?.tokenType, let refreshToken = self.token?.refreshToken {
                do {
                    try keychain.synchronizable(true).set("\(accessToken)", key: "accessToken.accessToken")
                    try keychain.synchronizable(true).set("\(type)", key: "accessToken.tokenType")
                    try keychain.synchronizable(true).set("\(refreshToken)", key: "accessToken.refreshToken")
                    if let idToken = self.token?.idToken {
                        try keychain.synchronizable(true).set("\(idToken)", key: "accessToken.idToken")
                    }
                    if let accessTokenExpiry = self.token?.accessTokenExpiry {
                        let timeInterval = accessTokenExpiry.timeIntervalSinceReferenceDate
                        try keychain.synchronizable(true).set("\(timeInterval)", key: "accessToken.accessTokenExpiry")
                    }
                }catch {}
            }
        }
    }
    
    open func refreshAccessToken(completion: @escaping (Bool)-> Void) {
        if AuthManagerDynamicForm.shared.refreshToken != "" {
            let headers = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json", "TenantId": AuthManagerDynamicForm.shared.tenant?.tenantId ?? ""]
            let parameters = [
                "client_id": "\(self.configuration.clientId)",
                "client_secret": "\(self.configuration.clientSecret)",
                "redirect_uri": "\(self.configuration.redirectURL)",
                "refresh_token": "\(AuthManagerDynamicForm.shared.refreshToken)",
                "grant_type": "refresh_token",
                "code_verifier": "\(self.configuration.codeVerifer)",
                "platform": "ios",
                "lang": isArabic() ? "ar" : "en"
            ]
            AF.request(self.configuration.tokenURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders(headers)).validate().responseData { responseData in
                do {
                    guard let data = responseData.data else {
                        self.clientDidFailLoadingToken(OAuth2Error(localizedTitle: "Invalid response", localizedDescription: "No data received"))
                        return
                    }
                    let json = try JSON(data: data)
                    if let responseCode = responseData.response?.statusCode {
                        if responseCode == 200 {
                            self.token = OAuth2Token()
                            self.token?.accessToken = json["access_token"].stringValue
                            self.token?.refreshToken = json["refresh_token"].stringValue
                            self.token?.tokenType = json["token_type"].stringValue
                            self.token?.idToken = json["id_token"].stringValue
                            AuthManagerDynamicForm.shared.token =  json["access_token"].stringValue
                            AuthManagerDynamicForm.shared.refreshToken =  json["refresh_token"].stringValue
                            AuthManagerDynamicForm.shared.fetchProfile()
                            self.observeProfileAndNotify()

                            print("lang in refreshToken is = ", json["lang"].stringValue)
                            self.token?.accessTokenExpiry = Date().addingTimeInterval(json["expires_in"].doubleValue)
                            self.saveToken()
                            completion(true)
                        }
                        else {
                            self.clientDidFailLoadingToken(OAuth2Error(localizedTitle: "Authentication failed", localizedDescription: "Authentication failed, resonse: \n\(json)"))
                            AuthManagerDynamicForm.shared.unauthorizedFlag.accept(true)
                            completion(false)
                        }
                    } else {
                        self.clientDidFailLoadingToken(OAuth2Error(localizedTitle: "Invalid response", localizedDescription: "Invalid OAuth2 token response"))
                        AuthManagerDynamicForm.shared.unauthorizedFlag.accept(true)
                    }
                } catch {
                    self.clientDidFailLoadingToken(OAuth2Error(localizedTitle: "Invalid response", localizedDescription: "Invalid OAuth2 token response"))
                    AuthManagerDynamicForm.shared.unauthorizedFlag.accept(true)
                }
            }
        } else {
            self.clientDidFailLoadingToken(OAuth2Error(localizedTitle: "RefreshToken missing", localizedDescription: "Invalid OAuth2 refresh token"))
            AuthManagerDynamicForm.shared.unauthorizedFlag.accept(true)
        }
    }
}
*/
