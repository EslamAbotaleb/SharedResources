//

//  SwiftMVVMStartupProject
//
//  Created by Maher on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation

@_exported import Promises
internal import FBLPromises

public typealias UploadProgrssCallBack = ((Double,FileVersionType)->())
public typealias ProgressCallback = (Double) -> Void

// Internal protocol - uses Promise internally
protocol Network {
    func call(endpoint: Endpoint) -> Promise<Data>
    func callModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint) -> Promise<Model>
    func uploadModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint,progressCallBack: @escaping UploadProgrssCallBack) -> Promise<Model>
    func downloadModel( filesUrl: [String]) -> Promise<URL>
    func cancelUpload(_ fileVersionType: FileVersionType) -> Void
}
// Public protocol - uses completion handlers instead of Promise
public protocol NetworkService {
    func callModel<Model: Codable>(
        _ model: Model.Type,
        endpoint: Endpoint,
        completion: @escaping (Swift.Result<Model, Error>) -> Void
    )
    
    func uploadModel<Model: Codable>(
        _ model: Model.Type,
        endpoint: Endpoint,
        progressCallBack: @escaping UploadProgrssCallBack,
        completion: @escaping (Swift.Result<Model, Error>) -> Void
    )
    
    func downloadModel(
        filesUrl: [String],
        completion: @escaping (Swift.Result<URL, Error>) -> Void
    )
    
    func cancelUpload(_ fileVersionType: FileVersionType)
}

