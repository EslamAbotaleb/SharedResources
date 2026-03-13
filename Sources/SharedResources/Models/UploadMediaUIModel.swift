//
//  UploadMediaUIModel.swift
//  CERQEL
//
//  Created by hassan elshaer on 24/12/2024.
//  Copyright © 2024 Youxel. All rights reserved.
//

import Foundation
import UIKit
public import Alamofire

public class UploadMediaUIModel {
    public var id: String
    public var uploadedMedia: ModelUploadedMedia?
    public var state: UploadingState
   var request: UploadRequest?

    public init(
        id: String, uploadedMedia: ModelUploadedMedia? = nil,
        state: UploadingState, request: UploadRequest? = nil
    ) {
        self.id = id
        self.uploadedMedia = uploadedMedia
        self.state = state
        self.request = request
    }

    public enum UploadingState {
        case failed, success
        case inProgress(Double)
    }
}
