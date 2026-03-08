//
//  ThemeManager.swift
//  CERQEL
//
//  Created by ahmed maher on 23/12/2024.
//  Copyright © 2024 Youxel. All rights reserved.
//

import Foundation
import UIKit

class ThemeManager {
    static let shared = ThemeManager()

    private let accessManagmentRepo = AccessManagmentRepoImpl()


    private init() {}

    // Fetch theme and configuration
    func getThemeAndConfiguration(completion: @escaping (Bool) -> Void) {
        accessManagmentRepo.getThemeWithConfiguration().then { [weak self] (response) in
            guard let self = self else { return }
            
            if let colors = response.result.data.platformsColor {
                self.setTheme(for: colors)
            }
            else {
                self.getPreviousTheme()
            }

            completion(true)
        }.catch { [weak self] (error) in
            self?.getPreviousTheme()
            completion(false)
        }
    }

    // Set theme colors
    private func setTheme(for colors: PlatformsColor) {
        if let primaryColor = colors.primaryColorMain {
            primaryMain = UIColor(hexCerqel: primaryColor) ?? primaryMain
            UserDefaults.standard.setColor(color: primaryMain, forKey: "primaryMain")
        }

        if let lightColor = colors.primaryColorLight {
            primaryLight = UIColor(hexCerqel: lightColor) ?? primaryLight
            UserDefaults.standard.setColor(color: primaryLight, forKey: "primaryLight")
        }

        if let secondaryMColor = colors.secondaryColorMain {
            secondaryMain = UIColor(hexCerqel: secondaryMColor) ?? secondaryMain
            UserDefaults.standard.setColor(color: secondaryMain, forKey: "secondaryMain")
        }

        if let secondaryLColor = colors.secondaryColorLight {
            secondaryLight = UIColor(hexCerqel: secondaryLColor) ?? secondaryLight
            UserDefaults.standard.setColor(color: secondaryLight, forKey: "secondaryLight")
        }

        if let typographyT = colors.typographyColorHeading {
            typographyTitle = UIColor(hexCerqel: typographyT) ?? typographyTitle
            UserDefaults.standard.setColor(color: typographyTitle, forKey: "typographyTitle")
        }

        if let typographySub = colors.typographyColorSubtitle {
            typographySubtitle = UIColor(hexCerqel: typographySub) ?? typographySubtitle
            UserDefaults.standard.setColor(color: typographySubtitle, forKey: "typographySubtitle")
        }

        if let typographBody = colors.typographyColorBody {
            typographyBody = UIColor(hexCerqel: typographBody) ?? typographyBody
            UserDefaults.standard.setColor(color: typographyBody, forKey: "typographBody")
        }

        if let background = colors.backgroundColor {
            bg = UIColor(hexCerqel: background) ?? bg
            UserDefaults.standard.setColor(color: bg, forKey: "bg")
        }

        if let bgH = colors.mainHeaderColorBg {
            bgHeader = UIColor(hexCerqel: bgH) ?? bgHeader
            UserDefaults.standard.setColor(color: bgHeader, forKey: "bgHeader")
        }

        if let bgN = colors.mobileBgTabNavigatorColor {
            bgTabNavigation = UIColor(hexCerqel: bgN) ?? bgTabNavigation
            UserDefaults.standard.setColor(color: bgTabNavigation, forKey: "bgTabNavigation")
        }

        if let bgHC = colors.mobileBgHeaderColor {
            bgHColor = UIColor(hexCerqel: bgHC) ?? bgHColor
            UserDefaults.standard.setColor(color: bgHColor, forKey: "bgHColor")
        }
        if let sideMenuBg = colors.sideMenuColorBg {
            sideMenuBG = UIColor(hexCerqel: sideMenuBg) ?? sideMenuBG
            UserDefaults.standard.setColor(color: sideMenuBG, forKey: "sideMenuBG")
        }

        if let sideMenuColorText = colors.sideMenuColorTextAndIcons {
            sideMenuTextColor = UIColor(hexCerqel: sideMenuColorText) ?? sideMenuTextColor
            UserDefaults.standard.setColor(color: sideMenuTextColor, forKey: "sideMenuColorTextAndIcons")
        }

        if let sideMenuColorHighlight = colors.sideMenuColorHighlight {
            sideMenuColorhighLight = UIColor(hexCerqel: sideMenuColorHighlight) ?? sideMenuColorhighLight
            UserDefaults.standard.setColor(color: sideMenuColorhighLight, forKey: "sideMenuColorhighLight")
        }


        self.setupNavigationAppearance()
    }

    // Configure navigation appearance
    private func setupNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        if #available(iOS 15, *) {
            appearance.configureWithOpaqueBackground()
        }
        appearance.backgroundColor = bgHColor
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: typographyTitle,
            NSAttributedString.Key.font: UIFont.bodyLMedium()
        ]
        appearance.buttonAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: typographyTitle,
            NSAttributedString.Key.font: UIFont.bodyLMedium()
        ]
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: typographyTitle,
            NSAttributedString.Key.font: UIFont.bodyLMedium()
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    private func getPreviousTheme() {

        if let primaryColor = UserDefaults.standard.colorForKey(key: "primaryMain") {
            primaryMain = primaryColor
            var window: UIWindow?
            window?.tintColor = primaryMain
        }

        if let lightColor = UserDefaults.standard.colorForKey(key: "primaryLight") {
            primaryLight = lightColor
        }

        if let secondaryMColor = UserDefaults.standard.colorForKey(key: "secondaryMain") {
            secondaryMain = secondaryMColor
        }

        if let secondaryLColor = UserDefaults.standard.colorForKey(key: "secondaryLight") {
            secondaryLight = secondaryLColor
        }

        if let typographyT = UserDefaults.standard.colorForKey(key: "typographyTitle") {
            typographyTitle = typographyT
            self.setupNavigationAppearance()
        }

        if let typographySub = UserDefaults.standard.colorForKey(key: "typographySubtitle") {
            typographySubtitle = typographySub
        }

        if let typographBody = UserDefaults.standard.colorForKey(key: "typographBody") {
            typographyBody = typographBody
        }

        if let background = UserDefaults.standard.colorForKey(key: "bg") {
            bg = background
        }

        if let bgH = UserDefaults.standard.colorForKey(key: "bgHeader") {
            bgHeader = bgH
        }

        if let bgN = UserDefaults.standard.colorForKey(key: "bgTabNavigation") {
            bgTabNavigation = bgN
        }

        if let bgHC = UserDefaults.standard.colorForKey(key: "bgHColor") {
            bgHColor = bgHC
        }
        if let sideMenuBg = UserDefaults.standard.colorForKey(key: "sideMenuBG") {
            sideMenuBG = sideMenuBg
        }

        if let sideMenuColorTextAndIcons = UserDefaults.standard.colorForKey(key: "sideMenuColorTextAndIcons") {
            sideMenuTextColor = sideMenuColorTextAndIcons
        }

        if let sideMenuColorHighlight = UserDefaults.standard.colorForKey(key: "sideMenuColorhighLight") {
            sideMenuColorhighLight = sideMenuColorHighlight
        }

        self.setupNavigationAppearance()

    }
}
