//
//  AppDelegate.swift
//  FoodTracking
//
//  Created by Zach Owens on 1/16/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit

#if DEBUG
    import AdSupport
#endif
import Leanplum

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        Leanplum.setDeviceId(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
        Leanplum.setAppId("app_DqqSuuZsIk3ZEPZ1BB61FgF0DkE8CwPWMspc3aZc1wo",
                          withDevelopmentKey:"dev_ehNpFyhd8Z6dVIMMmPdDvYpXbUPmF77QmudiSv6eoKI")
        #else
        Leanplum.setAppId("app_DqqSuuZsIk3ZEPZ1BB61FgF0DkE8CwPWMspc3aZc1wo",
                          withProductionKey: "prod_qUO18dCAUE4omPytGCyipJcLAmLbnqtQRh863yxnKZw")
        #endif
        
        // Optional: Tracks in-app purchases automatically as the "Purchase" event.
        // To require valid receipts upon purchase or change your reported
        // currency code from USD, update your app settings.
        // Leanplum.trackInAppPurchases()
        
        // Optional: Tracks all screens in your app as states in Leanplum.
        // Leanplum.trackAllAppScreens()
        
        // Optional: Activates UI Editor.
        // Requires the Leanplum-iOS-UIEditor framework.
        // LeanplumUIEditor.shared().allowInterfaceEditing()
        
        // Starts a new session and updates the app content from Leanplum.
        Leanplum.start()
        
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

