//
//  Sharedcerqel_CodableResponseProtocol.swift
//  CERQEL
//
//  Created by iSlam on 10/11/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import Foundation
internal import RxSwift
internal import Alamofire

protocol Sharedcerqel_CodableResponseProtocol: Decodable {
    func parse<T: Decodable>(_ data: Data) -> Observable<T>
    var action: Sharedcerqel_APIAction { get }
}
