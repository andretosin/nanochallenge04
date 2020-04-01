//
//  AppDelegate.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 04/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//
// APP ID: ca-app-pub-6710438178084678~1970026090
// AD ID:  ca-app-pub-6710438178084678/5829735278/
// TEST AD:ca-app-pub-3940256099942544/4411468910


import UIKit
import SwiftUI
import GoogleMobileAds
import GameKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let hostVc = UIHostingController(rootView: MenuView())
    
        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = hostVc
        self.window?.makeKeyAndVisible()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    
}

