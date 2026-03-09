//
//  NetworkService.swift
//  CERQEL
//
//  Created by iSlam on 10/11/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import Foundation
@_exported import RxSwift

protocol Sharedcerqel_NetworkServiceD {
     func load<T>(_ resource: T) -> Observable<T> where T : Sharedcerqel_CodableResponseProtocol
     func load<T>(_ resource: cerqel_ArrayResource<T>) -> Observable<[T]>
}
