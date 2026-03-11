//
//  SharedUIButton+Extensions.swift
//  SharedResources
//
//  Created by Eslam on 11/03/2026.
//

import UIKit

extension UIButton{
    public func cerqel_setGradientColor(isVertical: Bool, colors: [UIColor]){
        let gradientLayer = CAGradientLayer(isVertical: isVertical, frame: self.frame, colors: colors)
        self.setBackgroundImage(gradientLayer.cerqel_createGradientImage(), for: .normal)
    }
}
