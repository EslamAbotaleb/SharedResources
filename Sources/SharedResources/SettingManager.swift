//
//  SettingManager.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation
import UIKit

public class SettingManager {
   static public func openSettings() {
       guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
           return
       }
       UIApplication.shared.open(settingsURL)
    }
 
}
