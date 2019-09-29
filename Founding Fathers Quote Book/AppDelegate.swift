//
//  AppDelegate.swift
//  Founding Fathers Quote Book
//
//  Created by Nick Mahe on 9/10/19.
//  Copyright © 2019 Nick Mahe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    // Properties
    var window: UIWindow?
    
    // Application Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (_, _) in
            // Nothing to do
        }
        window?.makeKeyAndVisible()
        return true
    }
/* FOR IOS 13
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
*/
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        segueToQuoteOfTheDay()
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        segueToQuoteOfTheDay()
        completionHandler(UNNotificationPresentationOptions())
    }
    
    // HELPERS
    
    private func segueToQuoteOfTheDay() {
        if let navVC = window?.rootViewController as? UINavigationController{
            navVC.dismiss(animated: true)
            
            if let quoteVC = navVC.viewControllers.first as? QuoteViewController{
                quoteVC.showQuoteOfTheDay()
            }
        }
    }

}

