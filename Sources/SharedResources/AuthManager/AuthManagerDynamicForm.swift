//
//  AuthManagerDynamicForm.swift
//  GAZT
//
//  Created by iSlam AbdelAziz on 12/20/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import UIKit
import Foundation
internal import RxCocoa
internal import RxSwift
internal import MOLH

public class AuthManagerDynamicForm {

    private let service: cerqel_NetworkServiceDynamicForm = cerqel_BasicNetworkServiceDynamicFormImpl.shared
    private let disposeBag = DisposeBag()
    public var isTasks = true
    public var isAuthorized = false
    public var userProfile = ""
    public var isPopUpFromFormBuilder:((String) -> ())?
    static nonisolated(unsafe) public var shared = AuthManagerDynamicForm()
    var isRequestSubmitted = false
    public var token: String = ""{
        didSet{
            UserDefaults.standard.set(token, forKey: "Token")
        }
    }
    
    var modules: [String:Any]? = [String:Any]()
    public var refreshToken: String = ""{
        didSet{
            UserDefaults.standard.set(refreshToken, forKey: "RefreshToken")
        }
    }

   public var is_single_tenant: Bool {
        get {
            UserDefaults.standard.bool(forKey: "is_single_tenant")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "is_single_tenant")
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
    
    var unauthorizedFlag: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    var isInboxRefreshRequired = false
    var optionsRetreived = [MCQOption]()
    var profile: DynamicObjects<ModelUserProfileDataCerqel?> = DynamicObjects( nil)

    var profilePicture: DynamicObjects<(UIImage?,Data?)?> = DynamicObjects(nil)

    var newSubmissionRetreiveEnabled = true
    
    public init() {
        self.token = UserDefaults.standard.string(forKey: "Token") ?? ""
        self.refreshToken = UserDefaults.standard.string(forKey: "RefreshToken") ?? ""
    }
    
    func fetchProfile(){
        self.service.load(cerqel_CodableResponseObjectDynamicForm<ModelUserProfileDataCerqel>(action: cerqel_BasicActionDynamicForm.fetchProfile)).subscribe(onNext: {
            [weak self] (response) in
            if let obj = response.item?.data{
                self?.profile.value = obj
            }
        }, onError: { (error) in
            print(error)

        }).disposed(by: self.disposeBag)
    }
    
    func decode(jwtToken jwt: String) -> [String: Any]? {
        
        let segments = jwt.components(separatedBy: ".")
        guard segments.count > 1 else { return nil }

        var base64String = segments[1]
        
        // Pad base64 string as needed
        let requiredLength = 4 * ((base64String.count + 3) / 4)
        let paddingLength = requiredLength - base64String.count
        if paddingLength > 0 {
            base64String += String(repeating: "=", count: paddingLength)
        }

        // Replace URL-safe characters
        base64String = base64String
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        guard let decodedData = Data(base64Encoded: base64String),
              let jsonObject = try? JSONSerialization.jsonObject(with: decodedData),
              let payload = jsonObject as? [String: Any] else {
            return nil
        }

        return payload
    }
}
