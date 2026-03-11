//

//  SwiftMVVMStartupProject
//
//  Created by Maher on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
@_exported import Promises

public typealias UploadProgrssCallBack = ((Double,FileVersionType)->())
public typealias ProgressCallback = (Double) -> Void

// hint: you can't use protocol Network as public cause of plugin Promises defined as internal import that's why not define protocol as public
public protocol SharedNetwork {
    func call(endpoint: SharedEndpoint) -> Promise<Data>
    func callModel<Model: Codable>(_ model: Model.Type, endpoint: SharedEndpoint) -> Promise<Model>
    func uploadModel<Model: Codable>(_ model: Model.Type, endpoint: SharedEndpoint,progressCallBack: @escaping UploadProgrssCallBack) -> Promise<Model>
    func downloadModel( filesUrl: [String]) -> Promise<URL>
    func cancelUpload(_ fileVersionType: FileVersionType) -> Void
}
