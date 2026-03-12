//
//  LocalNotificationManager.swift
//  Azkary
//
//  Created by ahmed maher on 15/06/2023.
//

import Foundation
import UserNotifications
import AVFoundation

public protocol localNotificationDelegate {
    func didAcceptNotification()
    func didReject(error: Error)
}

internal protocol LocalNotificationProtocol {
    func scheduleLocalNotification(file: FileModel)
    func checkNotificationPermission()
    var delegate:localNotificationDelegate? { get set }
}


public class LocalNotificationManager : LocalNotificationProtocol {
    
    public var scheduledNotificationIdentifiers: [String] = []
    
    static public let shared = LocalNotificationManager()
    public var delegate: localNotificationDelegate?
    
    
    private init() {
        requestNotificationAuthorization()
        
    }
    
    public func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                self.delegate?.didAcceptNotification()
                print("تمت الموافقة على الإشعارات المحلية🧡")
            } else {
                DispatchQueue.main.async {
                  //  self.delegate?.didReject(error: CustomError("تم رفض الوصول إلى الإشعارات المحلية💛"))
                }
                
            }
        }
    }
    
    public func checkNotificationPermission() {
         UNUserNotificationCenter.current().getNotificationSettings { settings in
             if settings.authorizationStatus == .denied {
                 DispatchQueue.main.async {
                     //self.delegate?.didReject(error: CustomError("تم رفض الوصول إلى الإشعارات المحلية💛"))
                 }
             }
             else if settings.authorizationStatus == .authorized {
                 self.delegate?.didAcceptNotification()
             }
             
         }
     }
    
    internal func scheduleLocalNotification(file: FileModel) {
        scheduleNotification(id: file.id, title: file.title, fileExtension: file.fileExtension, fileURL: file.localFileUrl?.absoluteString)
    }

    public func scheduleNotification(id: String, title: String, fileExtension: String, fileURL: String?) {
        let content = UNMutableNotificationContent()

        content.title = title + ".\(fileExtension)"
        content.body = "File Downloaded Successfully".localized
        content.launchImageName = "Youxel"
        content.userInfo = ["fileURL": fileURL ?? ""]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    
    public func cancelNotification(with identifier: String) {
        // Remove the identifier from the array
        if let index = scheduledNotificationIdentifiers.firstIndex(of: identifier) {
            scheduledNotificationIdentifiers.remove(at: index)
        }
        // Cancel the notification
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
