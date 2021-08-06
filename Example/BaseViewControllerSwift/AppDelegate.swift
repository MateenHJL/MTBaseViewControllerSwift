//
//  AppDelegate.swift
//  BaseViewControllerSwift
//
//  Created by 13162378587@163.com on 08/03/2021.
//  Copyright (c) 2021 13162378587@163.com. All rights reserved.
//

import UIKit
import BaseViewControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var tabbar : BaseTabbarController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        BaseViewControllerConfigManager.shareViewControllerConfig().setupHttpEngineWithConfig(config: TestConfig.init())
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.clear
        var array : Array<BaseTabbarItem> = []
        for i in 0...3 {
            let item : BaseTabbarItem = BaseTabbarItem.init()
            item.badgeValue = "3"
            item.selectedImage = UIImage.init(named: "authing")
            item.normalImage = UIImage.init(named: "authing")
            item.normalTitle = "哈哈"
            item.classInstance = CViewController.init()
            item.tabbarItemType = i
            array.append(item)
        }
        self.tabbar = BaseTabbarController.init()
        self.tabbar!.resetTabbarForDataModelArray(modelArray: array)
        self.window?.rootViewController = self.tabbar
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

