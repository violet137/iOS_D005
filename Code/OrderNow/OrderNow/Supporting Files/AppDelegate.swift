//
//  AppDelegate.swift
//  orderProject2
//
//  Created by Phu Vu on 9/5/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import UIKit
import FacebookCore
import FBSDKCoreKit
import GoogleSignIn
import Firebase
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        var navigationController = UINavigationController(rootViewController: ListBookBeforeComeViewController())
//        window?.backgroundColor = .white
//        window?.rootViewController = navigationController
//        window?.makeKey()

        
        // Initialize Facebook
        FBSDKCoreKit.ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Initialize Google
        GIDSignIn.sharedInstance().clientID = "948304192679-bdl94g5lpmpbm4q589rmk148mot92vo7.apps.googleusercontent.com"
        
        // Google map
        GMSServices.provideAPIKey("AIzaSyBhcNno9nYL3KmR5h3BYyOd2K4j8LPEKQ8")
        GMSPlacesClient.provideAPIKey("AIzaSyBhcNno9nYL3KmR5h3BYyOd2K4j8LPEKQ8")
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        GIDSignIn.sharedInstance()?.handle(url)
        return FBSDKCoreKit.ApplicationDelegate.shared.application(app, open: url, options: options)
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

