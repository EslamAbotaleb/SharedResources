//
//  File.swift
//  SharedResources
//
//  Created by Marwan Osama on 05/03/2026.
//

import Foundation
internal import MOLH
internal import JGProgressHUD

public func isArabic() -> Bool{
    return MOLHLanguage.isArabic()
}

func flashHud(message:String,view:UIView,indicator:JGProgressHUDIndicatorView) -> JGProgressHUD {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = message
    hud.indicatorView = nil
    hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
    hud.vibrancyEnabled = true
    hud.show(in: view)
    hud.dismiss(afterDelay: 2.0)
    return hud
}
