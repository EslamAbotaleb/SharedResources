//
//  NetworkServiceImpl.swift
//  SwiftMVVMStartupProject
//
//  Created by Maher on 6/14/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
@_exported import Promises
@_exported import Reachability
@_exported import SwiftyJSON
import CommonCrypto

protocol EndpointExecuter {
    func execute(_ endpoint: Endpoint) -> Promise<NetworkServiceResponse>
    func cancelUpload(_ fileVersionType: FileVersionType) -> Void
    func uploadMultipart(_ endpoint: Endpoint,progressCallBack: @escaping UploadProgrssCallBack) -> Promise<NetworkServiceResponse>
    func downloadFile(_ filesUrl: [String]) -> Promise<URL>
    func performRequest(_ request: URLRequest, completion: @escaping (BaseError?) -> Void)
}

protocol ReachabilityProtocol {
    func connection() -> Reachability.Connection?
}

public class SharedNetworkServiceImpl: SharedNetwork {

     var endpointExecuter: EndpointExecuter = SharedAlamofireService()
     var reachability: ReachabilityProtocol = ReachabilityImpl()

    public func callModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint) -> Promise<Model> {
        return Promise<Model>(on: .main) { fulfill, reject in
            self.call(endpoint: endpoint)
                .then({ (data) in
                    do {
                        //  print("Response Data 🤪🤪🤪🤪  \(JSON(data))")
                        let obj = try JSONDecoder().decode(Model.self, from: data)
                        fulfill(obj)
                    } catch let jsonError {
                        print("JsonSerlization Error 😱😱😱😱😱 \(jsonError.localizedDescription)")
                        reject(FailToMapResponseError(data: data))
                    }

                })
                .catch({ (error) in
                    if let error  = error as? ServerError, error.status == 401 {
                        guard !(SharedAuthManager.shared.unauthorizedFlag.value ?? false) else { return }
                        guard !SharedAuthManager.shared.token.isEmpty else {
                            reject(error)
                            return
                        }
                        
                        SharedTokenProvider.refreshToken? {
                                // Retry the request after token refresh
                                self.callModel(model, endpoint: endpoint)
                                                            .then(fulfill)
                                                            .catch(reject)
                        }
                    }
                    else {
                        reject(error)
                    }
                })
        }
    }

    public func uploadModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint,progressCallBack: @escaping UploadProgrssCallBack) -> Promise<Model> {
        return Promise<Model>(on: .main) { fulfill, reject in
            self.upload(endpoint: endpoint, progressCallBack: progressCallBack)
                .then({ (data) in
                    guard let response = try? JSONDecoder().decode(Model.self, from: data) else {
                        reject(FailToMapResponseError(data: data))
                        return
                    }
                    print("🎉🎉 After Codable : \(response)")
                    fulfill(response)})
                .catch({ (error) in
                    if let error  = error as? ServerError, error.status == 401 {
                        guard !(SharedAuthManager.shared.unauthorizedFlag.value ?? false) else { return }
                        SharedTokenProvider.refreshToken? {
                                // Retry the request after token refresh
                                self.uploadModel(model, endpoint: endpoint, progressCallBack: progressCallBack)
                                                            .then(fulfill)
                                                            .catch(reject)

                        }
                    }
                    else {
                        reject(error)
                    }

                })
        }
    }

    public func downloadModel( filesUrl: [String]) -> Promise<URL> {
        return Promise<URL>(on: .main) { fulfill, reject in
            self.download(filesUrl)
                .then({ (fileUrl) in
                    fulfill(fileUrl)})
                .catch({ (error) in
                    if let error  = error as? ServerError, error.status == 401 {
                        guard !(SharedAuthManager.shared.unauthorizedFlag.value ?? false) else { return }
                        SharedTokenProvider.refreshToken? { 
                                // Retry the request after token refresh
                                self.downloadModel(filesUrl: filesUrl)
                                                            .then(fulfill)
                                                            .catch(reject)

                        }
                    }
                    else {
                        reject(error)
                    }


                })
        }
    }

    public func call(endpoint: Endpoint) -> Promise<Data> {
        return Promise<Data>(on: .main) { fulfill, reject in
            self.endpointExecuter.execute(endpoint)
                .then({ (response) in
                    self.networkSuccess(data: response.data, statusCode: response.statusCode).then({ (data) in
                        do {
                            let header = response.headers as? [String: Any]
                            let jsonData = try JSONSerialization.data(withJSONObject: header, options: [])
                            let decoder = JSONDecoder()
                            let headerResponse = try decoder.decode(HeaderResponse.self, from: jsonData)
                            fulfill(data)
                        } catch {
                            // If header parsing fails, still fulfill with data
                            fulfill(data)
                        }
                    }).catch({ (error) in
                         reject(error)
                    })
                })
                .catch({ (error) in

                    if error is ServerError {
                        reject(error)
                    }
                    else {
                        reject(self.networkFail())
                    }
                })
        }
    }

    private func upload(endpoint: Endpoint,progressCallBack: @escaping UploadProgrssCallBack) -> Promise<Data> {
        return Promise<Data>(on: .main) { fulfill, reject in
            self.endpointExecuter.uploadMultipart(endpoint, progressCallBack: progressCallBack)
                .then({ (response) in
                    self.networkSuccess(data: response.data, statusCode: response.statusCode).then({ (data) in
                        fulfill(data)
                    }).catch({ (error) in
                        reject(error)
                    })
                }).catch({ _ in
                    reject(self.networkFail())
                })
        }
    }

    private func download(_ filesUrl: [String]) -> Promise<URL> {
        return Promise<URL>(on: .main) { fulfill, reject in
            self.endpointExecuter.downloadFile(filesUrl)
                .then({ (response) in

                    fulfill(response)
                }).catch({ error in
                    reject(self.networkFail())
                })


        }
    }

    public func cancelUpload(_ fileVersionType: FileVersionType) {
        self.endpointExecuter.cancelUpload(fileVersionType)
    }

    private func networkSuccess(data: Data, statusCode: Int?) -> Promise<Data> {
        return Promise<Data>(on: .main) { fulfill, reject in
            print("⬆️⬆️ Status Code : \(String(describing: statusCode ?? 0))")
            print("⬆️⬆️ Endpoint Respose : \(JSON(data))")

            if (200...299).contains(statusCode ?? 0) {
                fulfill(data)
            } else {
                guard let error = try? JSONDecoder().decode(ServerError.self, from: data) else {
                    if let statusCode = statusCode {
                        reject(ServerError(status: statusCode))
                    }
                    return
                }
                reject(error)
                if  statusCode == 401 {
                    SharedAuthManager.shared.unauthorizedFlag.accept(true)
                }
            }
        }
    }

    private func saveHeaders( _ header: HeaderResponse) {
        SharedUserAuthoriationHandler().setAuthManually(authToken: header.token ?? "")
        SharedUserAuthoriationHandler().setUidManually(uid: header.uid ?? "")    }

    private func networkFail() -> Error {
        return isConnectedToInternet ? FailToCallNetworkError() : NoInternetConnectionError()
    }

    private var isConnectedToInternet: Bool {
        return reachability.connection() != Reachability.Connection.unavailable
    }

    private func mapJsonToModel<Model: Codable>(_ model: Model.Type, from data: Data) -> Promise<Model>{
        return Promise<Model>(on: .main) { fulfill, reject in
            guard let response = try? JSONDecoder().decode(Model.self, from: data) else {
                return  reject(FailToMapResponseError(data: data))
            }
            return fulfill(response)
        }
    }

    public init() {}
}

public struct NetworkServiceResponse {
    var data: Data
    var statusCode: Int?
    var headers: [AnyHashable: Any]?
}

public class ReachabilityImpl: ReachabilityProtocol {
   func connection() -> Reachability.Connection? {
        return try? Reachability().connection
    }
}

public struct HeaderResponse: Codable {
    public var token: String?
    public var client: String?
    public var uid: String?

    enum CodingKeys: String, CodingKey {
        case token = "access-token"
        case client, uid
    }
}

