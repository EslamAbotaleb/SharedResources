//
//  LocalizedButton.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import UIKit

open class LocalizedButton: UIButton{
    override public func awakeFromNib() {
        self.setTitle(self.currentTitle?.localized, for: .normal)
    }
}

extension UIButton{
    public func cerqel_setGradientColor(isVertical: Bool, colors: [UIColor]){
        let gradientLayer = CAGradientLayer(isVertical: isVertical, frame: self.frame, colors: colors)
        self.setBackgroundImage(gradientLayer.cerqel_createGradientImage(), for: .normal)
    }
}
