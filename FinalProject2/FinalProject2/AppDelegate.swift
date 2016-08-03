//
//  AppDelegate.swift
//  FinalProject2
//
//  Created by Michael Zhou on 8/2/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.

//  Inspired by Karan's section, this is the simpler, functional version of the Conway's Game of Life App. I had used Karan's section code as a starter to rethink the process, and reset the overall view. A few stuff is added, which is my own, and then there comes all the stuff that comes with it. Note: I had did my own setup on another XCode project, but Karan then told me to create a new project based on the code structure of Van's ProjectPrototype and Karan's section code, and the original code on my project was very clunky and hard to read. This is why this FinalProject is a new FinalProject2 folder. 

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

