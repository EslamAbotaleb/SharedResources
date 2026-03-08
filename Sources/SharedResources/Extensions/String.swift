//
//  File.swift
//  SharedResources
//
//  Created by Marwan Osama on 05/03/2026.
//

import Foundation

public extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
