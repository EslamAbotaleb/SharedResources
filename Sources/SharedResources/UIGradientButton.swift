//
//  UIGradientButton.swift
//  GAZT
//
//  Created by iSlam AbdelAziz on 10/20/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import UIKit

@IBDesignable
public class UIGradientButton: LocalizedButton {
    
    
    @IBInspectable var firstColor: UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 1) {
        didSet{
            updateView()
        }
    }
    
    override public class var layerClass: AnyClass {
        get{
            return CAGradientLayer.self
        }
    }
    
    public func updateView() {
        
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor , secondColor.cgColor]
        layer.startPoint = startPoint
        layer.endPoint = endPoint
    }
    
}
