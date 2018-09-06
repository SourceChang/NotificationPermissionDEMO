//
//  ViewController.swift
//  NotificationPermissionDEMO
//
//  Created by Source_Chang on 2018/9/5.
//  Copyright © 2018年 Source_Chang. All rights reserved.
//


import UIKit
import UserNotifications


// MARK: - Definition
class ViewController: UIViewController {
    
    
    deinit {
        removeNotifications()
    }
    

}


// MARK: - Life Circle
extension ViewController {
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            self.requestPushNotificationAuthorization()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK: - Notifications
extension ViewController {
    
    
    /// 请求推送通知权限
    func requestPushNotificationAuthorization() {
        NSLog("start requestPushNotificationAuthorization")
        
        // 在请求权限的时候再添加通知监听，免得被 App 启动时的通知所干扰
        addNotifications()
        
        if #available(iOS 10.0, *) {
            let options: UNAuthorizationOptions = [.badge, .sound, .alert, .carPlay]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { (result, error) in
                NSLog("UNUserNotificationCenter requestAuthorizationFinishedWithResult: \(result)) error: \(String(describing: error))")
            }
        } else {
            //        UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    
    /// 添加通知监听
    func addNotifications() {
        removeNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.didReceiveApplicationWillResignActiveNotification(_:)), name: .UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.didReceiveApplicationDidBecomeActiveNotification(_:)), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    
    /// 移除通知监听
    func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    
}


// MARK: - Notification Actions
extension ViewController {
    
    
    /// 收到 UIApplicationWillResignActive 通知
    ///
    /// - Parameter notification: 通知对象
    @objc func didReceiveApplicationWillResignActiveNotification(_ notification: Notification) {
        NSLog("didReceiveApplicationWillResignActiveNotification)")
    }
    
    
    /// 收到 UIApplicationDidBecomeActive 通知
    ///
    /// - Parameter notification: 通知对象
    @objc func didReceiveApplicationDidBecomeActiveNotification(_ notification: Notification) {
        NSLog("didReceiveApplicationDidBecomeActiveNotification)")
    }
    
    
}

