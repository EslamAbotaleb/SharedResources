//
//  Bundle+SharedResources.swift
//  SharedResources
//
//  Created by Eslam on 12/03/2026.
//  Copyright © 2023 Youxel. All rights reserved.
//

import Foundation

extension Bundle {
    /// Returns the resource bundle for the SharedResources SPM package
    static var sharedResourcesModule: Bundle = {
        // In Swift 5.3+, SPM provides Bundle.module automatically
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        // Fallback for other configurations
        let bundleName = "SharedResources_SharedResources"
        
        if let bundle = Bundle.main.url(forResource: bundleName, withExtension: "bundle")
            .flatMap(Bundle.init(url:)) {
            return bundle
        }
        
        // Try to find the bundle by identifier
        if let bundle = Bundle(identifier: "SharedResources") {
            return bundle
        }
        
        // Last resort - the bundle containing this type
        return Bundle(for: BundleToken.self)
        #endif
    }()
    
    // Private token class for bundle lookup
    private final class BundleToken { }
}
