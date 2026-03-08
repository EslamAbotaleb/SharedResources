//
//  MaskedImageView.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import UIKit

@IBDesignable
public class MaskedImageView: UIImageView {
    
    public var maskImageView = UIImageView()
    
    @IBInspectable
    public var maskImage: UIImage?{
        didSet{
            maskImageView.image = maskImage
            maskImageView.frame = bounds
            mask = maskImageView
        }
    }
}
