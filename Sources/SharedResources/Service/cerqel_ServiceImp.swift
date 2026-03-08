//
//  ServiceImp.swift
//  CERQEL
//
//  Created by iSlam on 10/11/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import Foundation
internal import RxSwift
internal import RxAlamofire
import UIKit
internal import Alamofire
import CommonCrypto
internal import JGProgressHUD

struct cerqel_BasicNetworkServiceImpl: cerqel_NetworkService {


    static let shared = cerqel_BasicNetworkServiceImpl()


    func load<T>(_ resource: T) -> Observable<T> where T : cerqel_CodableResponseProtocol {
        return
        RxAlamofire
            .request(resource.action)
            .validate(statusCode: 200 ..< 401)
            .responseJSON()
            .do(onError: { err in
                if let val = err as? AFError, val.responseCode == 401
                {
                    guard !(AuthManagerDynamicForm.shared.unauthorizedFlag.value ?? false) else { return }
                    TokenManager.shared.refreshToken {
                        // Retry the request after token refresh

                        _ = self.load(resource).subscribe(onNext: { result in
                        }, onError: { retryError in

                        })
                    }

                }

            })
            .map { $0.data }
            .filter { $0 != nil }
            .map { $0! }
            .flatMap(resource.parse)
    }
    //
    func uploadImage<T>(
        _ resource: cerqel_CodableResponseObject<T>,
        image: UIImage?,
        imageParam: String
    ) -> Observable<cerqel_CodableResponseObject<T>> where T: Decodable {

        return Observable.create { observer in

            let parameters: [String: Any] = resource.action.actionParameters

            let uploadRequest = AF.upload(
                multipartFormData: { multipartFormData in

                    if let image = image,
                       let imageData = image.jpegData(compressionQuality: 0.4) {
                        multipartFormData.append(
                            imageData,
                            withName: imageParam,
                            fileName: "file.jpg",
                            mimeType: "image/jpeg"
                        )
                    }

                    for (key, value) in parameters {
                        switch value {
                        case let intValue as Int:
                            multipartFormData.append(
                                "\(intValue)".data(using: .utf8)!,
                                withName: key
                            )

                        case let doubleValue as Double:
                            multipartFormData.append(
                                "\(doubleValue)".data(using: .utf8)!,
                                withName: key
                            )

                        case let stringValue as String:
                            multipartFormData.append(
                                stringValue.data(using: .utf8)!,
                                withName: key
                            )

                        default:
                            break
                        }
                    }

                },
                to: resource.action.baseURL.appending(resource.action.path),
                method: .post,
                headers: HTTPHeaders(resource.action.authHeader)
            )

            uploadRequest.responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder()
                            .decode(cerqel_CodableResponseObject<T>.self, from: data)
                        observer.onNext(result)
                        observer.onCompleted()
                    } catch {
                        observer.onError(BaseError.decodeResponse)
                    }

                case .failure:
                    observer.onError(BaseError.serverError)
                }
            }

            return Disposables.create {
                uploadRequest.cancel()
            }
        }
    }



    func load<T>(_ resource: cerqel_ArrayResource<T>) -> Observable<[T]> where T : Codable {
        return
        RxAlamofire
            .request(resource.action)
            .responseJSON()
            .map { $0.data ?? Data() }
            .flatMap(resource.parse)
    }


}
