//
//  DynamicFormTokenProvider.swift
//  SharedResources
//
//  Created by Eslam on 08/03/2026.
//

import Foundation

public class DynamicFormTokenProvider {
    public static var refreshToken: ((@escaping (String?) -> Void) -> Void)?
    private init() {}
}
