//
//  CollectionViewExtensions.swift.swift
//  SharedResources
//
//  Created by Eslam on 15/03/2026.
//

import Foundation
import UIKit

extension UICollectionView {
    public func registerSharedCell<T: UICollectionViewCell>(cellType: T.Type) {
        let identifier = String(describing: T.self)
        self.register(UINib(nibName: identifier, bundle: Bundle.module), forCellWithReuseIdentifier: identifier)
    }
}
