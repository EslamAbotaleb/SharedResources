//
//  NetworkServicePublic.swift
//  Created by Eslam on 09/03/2026.
//

import Foundation

/// Public wrapper class that bridges internal Promise-based implementation
/// to public completion handler-based API
open class NetworkServicePublic: NetworkService {
    
    private let internalService: Network
    
    public init() {
        self.internalService = NetworkServiceImpl()
    }
    
    // For testing or custom implementations
    init(internalService: Network) {
        self.internalService = internalService
    }
    
    public func callModel<Model: Codable>(
        _ model: Model.Type,
        endpoint: Endpoint,
        completion: @escaping (Swift.Result<Model, Error>) -> Void
    ) {
        internalService.callModel(model, endpoint: endpoint)
            .then { result in
                completion(.success(result))
            }
            .catch { error in
                completion(.failure(error))
            }
    }
    
    public func uploadModel<Model: Codable>(
        _ model: Model.Type,
        endpoint: Endpoint,
        progressCallBack: @escaping UploadProgrssCallBack,
        completion: @escaping (Swift.Result<Model, Error>) -> Void
    ) {
        internalService.uploadModel(model, endpoint: endpoint, progressCallBack: progressCallBack)
            .then { result in
                completion(.success(result))
            }
            .catch { error in
                completion(.failure(error))
            }
    }
    
    public func downloadModel(
        filesUrl: [String],
        completion: @escaping (Swift.Result<URL, Error>) -> Void
    ) {
        internalService.downloadModel(filesUrl: filesUrl)
            .then { url in
                completion(.success(url))
            }
            .catch { error in
                completion(.failure(error))
            }
    }
    
    public func cancelUpload(_ fileVersionType: FileVersionType) {
        internalService.cancelUpload(fileVersionType)
    }
}
