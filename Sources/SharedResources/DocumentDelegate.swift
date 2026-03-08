//
//  SourceType.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation

public enum SourceType: Int {
    case files
    case folder
}

public protocol DocumentDelegate: AnyObject {
    func didPickDocuments(URLs: [URL]?, fromProfile: Bool)
}
