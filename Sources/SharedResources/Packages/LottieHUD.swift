//
//  LottieHUD.swift
//  GAZT
//
//  Created by iSlam AbdelAziz on 12/3/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import Foundation
internal import Lottie
import UIKit


/// enum for solid strat lotti mask
///
/// - solid: solid case description
public enum LottieHUDMaskType {
    case solid
}

/// class to generate Lottie animated HUD
@MainActor
public final class LottieHUD {
    
    /// struct for Lottie HUD initial configurations
    public struct LottieHUDConfig {
        @MainActor static var shadow: CGFloat = 0.0
        @MainActor static var animationDuration: TimeInterval = 0.1
    }
    
    private var maskView: UIView = {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.isUserInteractionEnabled = false
        bg.alpha = 0.0
        return bg
    }()
    
    
    private var _lottie: LottieAnimationView!
    
    public var contentMode: UIView.ContentMode = .scaleAspectFit {
        didSet {
            self._lottie.contentMode = contentMode
        }
    }
    
    public var maskType: LottieHUDMaskType = .solid

    public var size: CGSize = CGSize(width: 120, height: 120)
    
    var count = 0
    
    
    /// initializer constructor with lotti animation name
    ///
    /// - Parameters:
    ///   - name: lotti animation description
    ///   - loop: loop flag description
    init(_ name: String, loop: Bool = true) {
        self._lottie = LottieAnimationView(name: name)
        self._lottie.loopMode = loop ? .loop : .playOnce
        self._lottie.animationSpeed = 1.5//2.5
    }
    
    /// initializer constructor with lotti animation view
    ///
    /// - Parameter lottie: lottie view description
    init(_ lottie: LottieAnimationView) {
        self._lottie = lottie
    }
    
    /// method to generate Lottie HUD with no shadow and TimeInterval 0.3 second and no delay
    ///
    /// - Parameters:
    ///   - delay: delay value description
    ///   - loop: loop flag description
    public func showHUD(with delay: TimeInterval = 0.0, loop: Bool = true) {
        count += 1
        print("lottie animation HUD show count = \(count)")
        if count > 1 {
            print("lottie animation HUD show count > 1 = \(count)")
            return
        }
        self._lottie.loopMode = loop ? .loop : .playOnce
        createHUD(delay: delay)
    }
    
    /// method to stop hud animations and remove it
    public func stopHUD() {
        count -= 1
        print("lottie animation HUD stop count = \(count)")
        if count < 1 {
            count = 0
            print("lottie animation HUD stop count < 1 = \(count)")
            clearHUD()
        }
        
    }
    
    /// method to instantiate a hud view
    ///
    /// - Parameter delay: delay value description
    private func createHUD(delay: TimeInterval = 0.0) {
        UIApplication.shared.keyWindow!.isUserInteractionEnabled = false
        self.configureMask()
        self.configureConstraints()
        self.maskView.alpha = 1
        self._lottie.play(completion: { _ in
            self.clearHUD()
        })
    }
    
    /// method to setup mask shadow view
    private func configureMask() {
        if maskType == .solid {
            maskView.backgroundColor = UIColor.black.withAlphaComponent(LottieHUDConfig.shadow)
        } else {
            // Not implemented yet
        }
    }
    
    /// method to setup animation view contraints
    private func configureConstraints() {
        
        // Configure Backround View Constraints
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(self.maskView)
            maskView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 0).isActive = true
            maskView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: 0).isActive = true
            maskView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            maskView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        }
        maskView.addSubview(_lottie)

        // Configure Lottie Constraints
        _lottie.translatesAutoresizingMaskIntoConstraints = false
        _lottie.centerXAnchor.constraint(equalTo: maskView.centerXAnchor, constant: 0).isActive = true
        _lottie.centerYAnchor.constraint(equalTo: maskView.centerYAnchor, constant: 0).isActive = true
        _lottie.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        _lottie.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    /// metod to remove lotti view from super view
    private func clearHUD() {
        UIApplication.shared.keyWindow!.isUserInteractionEnabled = true
        self.maskView.removeFromSuperview()
        self._lottie.stop()
    }
    
}
