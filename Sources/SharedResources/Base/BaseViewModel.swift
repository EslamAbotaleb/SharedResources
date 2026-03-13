//
//  BaseViewModel.swift
//  Cerqel
//
//  Created by iSlam AbdelAziz on 10/27/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import Foundation
@_exported import RxCocoa
@_exported import RxSwift

open class BaseViewModel {
    public var errorsObservable: Observable<Error>!
    public var errorsSubject = PublishSubject<Error>()
    
    public var loadingObservable: Observable<BaseLoading>!
    public let loadingSubject = PublishSubject<BaseLoading>()
    
    public var alertMessage: DynamicObjects<String> = DynamicObjects("")

    
    // this should be required by all
   public init() {
        self.errorsObservable = errorsSubject.asObservable()
        self.loadingObservable = loadingSubject.asObservable()
    }
    
    public func showSystemAlert(alert: String) {
        alertMessage.value = alert
    }
    
    public func implementAlert(_ listener: @escaping (String) -> Void) {
        alertMessage.bind(listener)
    }
}
