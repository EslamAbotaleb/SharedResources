//
//  File.swift
//  SharedResources
//
//  Created by Marwan Osama on 08/03/2026.
//

import Foundation
internal import RxSwift
internal import RxCocoa

open class AuthManagerDynamicForm {
    
    private let service: cerqel_NetworkServiceDynamicForm = cerqel_BasicNetworkServiceDynamicFormImpl.shared
    private let disposeBag = DisposeBag()
    var documentTypesOfExtensions: [String] = []
    var isTasks = true
    static public var shared = AuthManagerDynamicForm()
    var isCameraOpened = false
    var newSubmissionRetreiveEnabled = true

    var isPopUpFromFormBuilder:((String) -> ())?
    var isInboxRefreshRequired = false

    public var token: String = ""{
        didSet{
            UserDefaults.standard.set(token, forKey: "Token")
        }
    }
    
    public var tenant: TenantListDTO? {
        get {
            guard let data = UserDefaults.standard.data(forKey: "tenant") else { return nil }
            let tenant = try? JSONDecoder().decode(TenantListDTO.self, from: data)
            return tenant
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: "tenant")
        }
    }
    
    func convertToUploadMediaUIModel(from attachment: AttachmentForDefault) -> UploadMediaUIModel {
        let state: UploadMediaUIModel.UploadingState = attachment.isSuccess ?? false ? .success : .success
        let uploadedMedia = ModelUploadedMedia(downloadUrl: attachment.downloadUrl,
                                               previewUrl: attachment.previewUrl,
                                               contentType: nil, // Set according to your requirement
                                               documentType: attachment.fileExtension, // Set according to your requirement
                                               fileSize: attachment.size,
                                               id: attachment.fileId,
                                               isPublic: attachment.isPublic,
                                               name: attachment.fileName,
                                               isStillUploading: false, // Not uploading again, so set to false
                                               additionalProperty01: nil,
                                               additionalProperty02: nil,
                                               additionalProperty03: nil,
                                               additionalProperty04: nil)
        
        return UploadMediaUIModel(id: attachment.fileId ?? "",
                                  uploadedMedia: uploadedMedia,
                                  state: state,
                                  request: nil)
    }
}
