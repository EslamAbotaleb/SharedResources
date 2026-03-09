//
//  WireframeInterfaceCerqel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

internal import Lottie
internal import JGProgressHUD


@MainActor
public protocol WireframeInterfaceCerqel: AnyObject {
    func cerqel_popFromNavigationController(animated: Bool)
    func cerqel_dismiss(animated: Bool)
    
    func cerqel_showErrorAlert(with message: String?)
    func cerqel_showAlert(with title: String?, message: String?)
    func cerqel_showAlert(with title: String?, message: String?, actions: [UIAlertAction])
}


extension UIViewController: WireframeInterfaceCerqel {
    
   public func cerqel_showError(error:Error){
        var message:String = error.localizedDescription
        if let error = error as? BaseError {
            
            message = error.errorDescription ?? ""
        }
        else {
            let code = (error as NSError).code
            if code == 3840{
                // not correct format
                message = BaseError.decodeResponse.localizedDescription
            }
            else if code == -1001 {
                // timeout
                message = BaseError.serverError.localizedDescription
            } else if code == -1009 {
                // no internet connection
                message = BaseError.NoInternet.localizedDescription
            }
            else {
                message = BaseError.timeOut.localizedDescription
            }
            // code == -1009 ||
        }
        let hud = flashHud(message: message, view: self.view, indicator: JGProgressHUDErrorIndicatorView())
        hud.dismiss(afterDelay: 2)
    }
    
    @MainActor
    private struct cerqel_HUDHolder {
        static var shared: LottieHUD = {
//            let hud = JGProgressHUD(style: .dark)
            let hud = LottieHUD("loading")
//            hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
//            hud.vibrancyEnabled = true
            return hud
            
        }()
    }
    
    public var cerqel_HUD: LottieHUD {
        get {
            return cerqel_HUDHolder.shared
        }
    }
    
    public func showError(error:Error, flashNow: Bool = false){
        var message:String = error.localizedDescription
        if flashNow {
            let hud = flashHud(message: message, view: self.view, indicator: JGProgressHUDErrorIndicatorView())
            hud.dismiss(afterDelay: 5)
        }
        if let error = error as? BaseError {
            
            message = error.errorDescription ?? ""
        }
        else {
            let code = (error as NSError).code
            if code == 3840{
                // not correct format
                message = BaseError.decodeResponse.localizedDescription
            }
            else if code == -1001 {
                // timeout
                message = BaseError.serverError.localizedDescription
            } else if code == -1009 {
                // no internet connection
                message = BaseError.NoInternet.localizedDescription
            }
            else {
                message = BaseError.timeOut.localizedDescription
            }
        }
        if message != BaseError.timeOut.localizedDescription {
            let hud = flashHud(message: message, view: self.view, indicator: JGProgressHUDErrorIndicatorView())
            hud.dismiss(afterDelay: 2)
        }
    }

    public func cerqel_popFromNavigationController(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }
    
    public func cerqel_dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
    
    public func cerqel_showErrorAlert(with message: String?) {
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        cerqel_showAlert(with: "Something went wrong", message: message, actions: [okAction])
    }
    
    public func cerqel_showAlert(with title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        cerqel_showAlert(with: title, message: message, actions: [okAction])
    }
    
    public func cerqel_showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    public func cerqel_showLoading(){
        cerqel_HUD.showHUD()
//        HUD.show(in: self.view)
    }
    
    public func cerqel_hideLoading(){
//        HUD.dismiss()
        cerqel_HUD.stopHUD()
    }
    
    
}


extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    public class var cerqel_storyboardID : String {
        
        return "\(self)"
    }
}


extension UIViewController{

    public func cerqel_presentSheetController(viewToPresent: BottomSheetVC, fullScreenModel: Bool = false, height: CGFloat, bottomControl: Bool = true){
        
        let mySize: SheetSize = .fixed(CGFloat(height))
        
        var sheet = SheetViewController(controller: viewToPresent, sizes: [mySize])
        if fullScreenModel{
            sheet = SheetViewController(controller: viewToPresent, sizes: [mySize])
        }
//        sheet.handleColor = UIColor.clear
//        sheet.adjustForBottomSafeArea = bottomControl
//        sheet.extendBackgroundBehindHandle = true
        
        viewToPresent.cerqel_sheetCtl = sheet
        self.present(sheet, animated: false, completion: nil)
        
        
    }

    public func cerqel_openMediaMenu(isFileOnly: Bool = false, isImgOnly: Bool = false){
        let alert = UIAlertController(title: "Choose Image Source".localized, message: "", preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: "Camera".localized, style: .default) { (_) in
            checkAuthorizationState(attachmentTypeEnum: .camera, vc: self,  parentView: self)
        }
        let actionGallary = UIAlertAction(title: "Photo Library".localized, style: .default) { (_) in
            checkAuthorizationState(attachmentTypeEnum: .photoLibrary, vc: self, parentView: self)
            
        }
        let actionCancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_) in
        }
        let actionFile = UIAlertAction(title: "File".localized, style: .default) { (_) in
            let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            if let sself = self as? UIDocumentPickerDelegate{
                importMenu.delegate = sself
            }
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)

        }
        if !isFileOnly {
            alert.addAction(actionCamera)
            alert.addAction(actionGallary)
        }
        if !isImgOnly {
            alert.addAction(actionFile)
        }
        
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)

    }
    
    public  func documentType(forFileExtension fileExtension: String) -> String? {
        if #available(iOS 14.0, *) {
            switch fileExtension {
            case "pdf": return UTType.pdf.identifier
            case "txt": return UTType.plainText.identifier
            case "rtf": return UTType.rtf.identifier
            case "csv": return UTType.commaSeparatedText.identifier
            case "msg": return UTType.message.identifier
            case "doc": return UTType.init("com.microsoft.word.doc")!.identifier
            case "docx": return UTType.init("org.openxmlformats.wordprocessingml.document")!.identifier
            case "xls": return UTType.init("com.microsoft.excel.xls")!.identifier
            case "xlsx": return UTType.init("org.openxmlformats.spreadsheetml.sheet")!.identifier
            case "ppt": return UTType.presentation.identifier
            case "pptx": return UTType.presentation.identifier
            case "pages": return UTType.init("com.apple.iwork.pages.pages")!.identifier
            case "numbers": return UTType.init("com.apple.iwork.numbers.numbers")!.identifier
            case "key": return UTType.init("com.apple.iwork.keynote.key")!.identifier
            case "zip": return UTType.zip.identifier
            case "rar": return UTType.init("com.rarlab.rar-archive")!.identifier
            case "7z": return UTType.init("org.7-zip.7-zip-archive")!.identifier
            case "json": return UTType.json.identifier
            case "xml": return UTType.xml.identifier
            default: return nil
            }

        } else {
            switch fileExtension {
            case "pdf": return "public.pdf"
            case "txt": return "public.plain-text"
            case "rtf": return "public.rtf"
            case "csv": return "public.comma-separated-values-text"
            case "msg": return "com.apple.mail-message"
            case "doc": return "com.microsoft.word.doc"
            case "docx": return "org.openxmlformats.wordprocessingml.document"
            case "xls": return "com.microsoft.excel.xls"
            case "xlsx": return "org.openxmlformats.spreadsheetml.sheet"
            case "ppt": return "com.microsoft.powerpoint.ppt"
            case "pptx": return "org.openxmlformats.presentationml.presentation"
            case "pages": return "com.apple.iwork.pages.pages"
            case "numbers": return "com.apple.iwork.numbers.numbers"
            case "key": return "com.apple.iwork.keynote.key"
            case "zip": return "public.zip-archive"
            case "rar": return "com.rarlab.rar-archive"
            case "7z": return "org.7-zip.7-zip-archive"
            case "json": return "public.json"
            case "xml": return "public.xml"
            default: return nil
            }
        }
    }
    
    public func openMFileMenu(attachmentExtensions: String) {
        AuthManagerDynamicForm.shared.documentTypesOfExtensions.removeAll()
        
        let alertStyle: UIAlertController.Style = UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet
        
        let alert = UIAlertController(title: "Choose Source".localized, message: "", preferredStyle: alertStyle)

        let actionCancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_) in
            // Handle cancellation if needed
        }

        alert.addAction(actionCancel)

        let extensions = attachmentExtensions
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }

        var hasFile = false
        var hasImage = false
        var hasVideo = false
        
        for ext in extensions {
            if isFileType(ext) {
                hasFile = true
                if #available(iOS 14.0, *),
                   let docType = documentType(forFileExtension: ext) {
                    AuthManagerDynamicForm.shared.documentTypesOfExtensions.append(docType)
                }
            } else if isImageType(ext) {
                hasImage = true
            } else if isVideoType(ext) {
                hasVideo = true
            }
        }

        if hasFile, !AuthManagerDynamicForm.shared.documentTypesOfExtensions.isEmpty {
            let fileAction = UIAlertAction(title: "File".localized, style: .default) { _ in
                let picker = UIDocumentPickerViewController(
                    documentTypes: AuthManagerDynamicForm.shared.documentTypesOfExtensions,
                    in: .import
                )
                if let delegate = self as? UIDocumentPickerDelegate {
                    picker.delegate = delegate
                }
                picker.modalPresentationStyle = .formSheet
                self.present(picker, animated: true)
            }
            alert.addAction(fileAction)
        }
        
        
        if hasImage {
            let cameraAction = UIAlertAction(title: "Camera".localized, style: .default) { _ in
                AuthManagerDynamicForm.shared.isCameraOpened = true
                checkAuthorizationState(
                    attachmentTypeEnum: .camera,
                    vc: self,
                    parentView: self
                )
            }
            
            let galleryAction = UIAlertAction(title: "Photo Library".localized, style: .default) { _ in
                checkAuthorizationState(
                    attachmentTypeEnum: .photoLibrary,
                    vc: self,
                    parentView: self
                )
            }
            
            alert.addAction(cameraAction)
            alert.addAction(galleryAction)
        }
        
        if hasVideo {
            let videoAction = UIAlertAction(title: "Video Library".localized, style: .default) { _ in
                checkAuthorizationState(
                    attachmentTypeEnum: .video,
                    vc: self,
                    parentView: self
                )
            }
            alert.addAction(videoAction)
        }

        self.present(alert, animated: true, completion: nil)
    }

    public func isFileType(_ attachExtension: String) -> Bool {
        let fileExtensions = [
            "pdf", "txt", "rtf", "csv", "msg", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "pages", "numbers", "key", "zip", "rar", "7z", "json", "xml"
        ]
        return fileExtensions.contains(attachExtension.lowercased())
    }

    public func isImageType(_ attachExtension: String) -> Bool {
        let imageExtensions = ["jpg", "png", "jpeg"]
        return imageExtensions.contains(attachExtension.lowercased())
    }
    
    public func isVideoType(_ attachExtension: String) -> Bool {
        let videoExtensions = ["mp4", "mov"]
        return videoExtensions.contains(attachExtension.lowercased())
    }

}
