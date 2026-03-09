//
//  File.swift
//  SharedResources
//
//  Created by Marwan Osama on 08/03/2026.
//

import Foundation
@_exported import RxSwift
@_exported import RxCocoa

open class SharedAuthManager {
    
    private let service: Sharedcerqel_NetworkServiceD = Sharedcerqel_BasicNetworkServiceImpl.shared
    private let disposeBag = DisposeBag()
    public var documentTypesOfExtensions: [String] = []
    public var isTasks = true
    static public var shared = SharedAuthManager()
    public var isCameraOpened = false
    public var newSubmissionRetreiveEnabled = true

    public var isPopUpFromFormBuilder:((String) -> ())?
    public var isInboxRefreshRequired = false
    var unauthorizedFlag: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    public var profile: DynamicObjects<ModelUserProfileDataCerqel?> = DynamicObjects(nil)
    
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
    
   public func fetchProfile(){
        self.service.load(Sharedcerqel_CodableResponseObject<ModelUserProfileDataCerqel>(action: Sharedcerqel_BasicAction.fetchProfile)).subscribe(onNext: {
            [weak self] (response) in
            if let obj = response.item?.data{
                self?.profile.value = obj
            }
        }, onError: { (error) in
            print(error)

        }).disposed(by: self.disposeBag)
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
