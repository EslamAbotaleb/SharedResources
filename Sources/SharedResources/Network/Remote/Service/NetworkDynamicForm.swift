//

//  SwiftMVVMStartupProject
//
//  Created by Maher on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation

internal import Promises
internal import FBLPromises

typealias UploadProgrssCallBack = ((Double,FileVersionType)->())
typealias ProgressCallback = (Double) -> Void

// hint: you can't use protocol Network as public cause of plugin Promises defined as internal import that's why not define protocol as public
protocol Network {
    func call(endpoint: Endpoint) -> Promise<Data>
    func callModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint) -> Promise<Model>
    func uploadModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint,progressCallBack: @escaping UploadProgrssCallBack) -> Promise<Model>
    func downloadModel( filesUrl: [String]) -> Promise<URL>
    func cancelUpload(_ fileVersionType: FileVersionType) -> Void
}
