//
//  SharedUITableViewCell+Extention.swift
//  SharedResources
//
//  Created by Eslam on 10/03/2026.
//

import UIKit
import Foundation

extension UITableViewHeaderFooterView{
    static public var cerqel_identifier: String {
        return String(describing: self)
    }
    
    static public var cerqel_nib : UINib{
        return UINib(nibName: cerqel_identifier, bundle: Bundle(for: Self.self))
    }
}

extension UITableViewCell{
    static public var cerqel_identifier: String {
        return String(describing: self)
    }
    
    static public var cerqel_nib : UINib{
        return UINib(nibName: cerqel_identifier, bundle: Bundle(for: Self.self))
    }
}
