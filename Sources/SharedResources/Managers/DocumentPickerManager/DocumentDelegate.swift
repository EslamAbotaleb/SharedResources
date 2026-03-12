//
//  DocumentDelegate.swift
//  SharedResources
//
//  Created by Eslam on 12/03/2026.
//

import Foundation

public enum SourceType: Int {
    case files
    case folder
}

public protocol DocumentDelegate: AnyObject {
    func didPickDocuments(URLs: [URL]?, fromProfile: Bool)
}
