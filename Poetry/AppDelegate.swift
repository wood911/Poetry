//
//  AppDelegate.swift
//  Poetry
//
//  Created by 伍腾飞 on 2017/5/23.
//  Copyright © 2017年 wtf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        EbaTestCode.stwa43("e7539a2b41a78112")
        EbaTestCode.strs4133x("-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQGC1/eh8sKhaa4qDZ+DrACZ5z\nPP46S9YyVdAhjIa8orolcgc2AJYNxQnU94HGd4Rbz/R3gVA8B6VplRJh7Yz43/P+\n1kaBls1TxUMBqYUhtTNFgK89NveaOAEU+V6XqxjKzc64DNw6/k2w1ZAmhRTFjJmK\nyslCmJVlbnZj0NqP5wIDAQAB\n-----END PUBLIC KEY-----")
        EbaTestCode.sync()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        EbaTestCode.sync()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

