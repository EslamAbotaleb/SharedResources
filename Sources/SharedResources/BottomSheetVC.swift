//
//  File.swift
//  SharedResources
//
//  Created by Marwan Osama on 05/03/2026.
//

import Foundation
import UIKit

public class BottomSheetVC: UIViewController {

    public var cerqel_sheetCtl: SheetViewController!
    public var cerqel_sheetHeight: CGFloat = 200

    public func setupBackButton() {
        let titleLabel = UILabel()
        titleLabel.text = "Back".localized
        titleLabel.textColor = typographyTitle
        let button = UIButton(type: .custom)
        if isArabic() {
            button.heightAnchor.constraint(equalToConstant: 15).isActive = true
            titleLabel.font = UIFont.bodyLRegular()
        } else {
            titleLabel.font = UIFont.bodyLRegular()
        }
        button.setImage(.init(named: "back1"), for: .normal)
        button.tintColor = typographyTitle
        if isArabic() { button.transform = .init(scaleX: -1, y: 1) }
        let stackview = UIStackView.init(arrangedSubviews: [button, titleLabel])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        if isArabic() {
            stackview.alignment = .lastBaseline
            stackview.spacing = 5
        } else {
            stackview.alignment = .center
            stackview.spacing = 5
        }
        stackview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        let leftBarButtonItem = UIBarButtonItem(customView: stackview)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc public func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
