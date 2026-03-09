//
//  LocalData.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//

import Foundation

public protocol LocalData {
    func get(key: CachingKey) -> Any?
    func get<T>(object: T.Type, key: CachingKey) -> T? where T: Decodable
    func objectFor(key: CachingKey) -> Any?
    func set(_ value: Any?, key: CachingKey)
    func set<T>(object: T, key: CachingKey) where T: Encodable
    func setDeviceToken( key: CachingKey)
    func removeObject(key: CachingKey)
}
