//
//  UploadMediaUIModel.swift
//  SharedResources
//
//  Created by Eslam on 09/03/2026.
//

import Foundation
internal import Alamofire

class UploadMediaUIModel {
    var id: String
    var uploadedMedia: ModelUploadedMedia?
    var state: UploadingState
    var request: UploadRequest?

    init(
        id: String, uploadedMedia: ModelUploadedMedia? = nil,
        state: UploadingState, request: UploadRequest? = nil
    ) {
        self.id = id
        self.uploadedMedia = uploadedMedia
        self.state = state
        self.request = request
    }

    enum UploadingState {
        case failed, success
        case inProgress(Double)
    }
}
