//
//  cerqel.swift
//  SharedResources
//
//  Created by Eslam on 08/03/2026.
//

import Foundation
internal import RxSwift

struct cerqel_ArrayResource<T: Codable> {
    public let objectType = T.self
    public let action: Sharedcerqel_APIAction
    
    public func parse(_ data: Data) -> Observable<[T]> {
        return Observable.create { observer in
            guard let result = try? JSONDecoder().decode([T].self, from: data) else {
                observer.onError(cerqel_CustomError(value: "Can't map response."))
                return Disposables.create()
            }
            
            observer.onNext(result)
            return Disposables.create()
        }
    }
}
