//
//  SharedTokenProvider.swift
//  SharedResources
//
//  Created by Eslam on 08/03/2026.
//

import Foundation

// MARK: - This class as bridge between real project for TokenManager (refreshToken) & Form Builder
public class SharedTokenProvider {
    public static var refreshToken: ((@escaping () -> Void) -> Void)?
    private init() {}
}
