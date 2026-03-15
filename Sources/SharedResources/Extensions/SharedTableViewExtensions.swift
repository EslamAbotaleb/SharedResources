//
//  TableViewExtensions.swift
//  CERQEL
//
//  Created by ahmed maher on 05/07/2023.
//  Copyright © 2023 Youxel. All rights reserved.
//

import Foundation
import UIKit

public enum SharedResourcesBundle {
    public static var bundle: Bundle { Bundle.module }
}

extension UICollectionView {
    public func registerSharedCell<T: UICollectionViewCell>(cellType: T.Type) {
        let identifier = String(describing: T.self)
        self.register(UINib(nibName: identifier, bundle: Bundle.module), forCellWithReuseIdentifier: identifier)
    }
}

extension UITableView {
    public func registerCell<T: UITableViewCell>(cellType: T.Type) {
        let bundle = Bundle(for: T.self)
        self.register(UINib(nibName: T.cerqel_identifier, bundle: bundle), forCellReuseIdentifier: T.cerqel_identifier)
    }

    public func registerSharedCell<T: UITableViewCell>(cellType: T.Type) {
        self.register(UINib(nibName: T.cerqel_identifier, bundle: Bundle.module), forCellReuseIdentifier: T.cerqel_identifier)
    }

    public func registerHaederFooterCell<T: UITableViewHeaderFooterView>(viewType: T.Type) {
        let bundle = Bundle(for: T.self)
        self.register(UINib(nibName: T.cerqel_identifier, bundle: bundle),
                      forHeaderFooterViewReuseIdentifier: T.cerqel_identifier)
    }
}
