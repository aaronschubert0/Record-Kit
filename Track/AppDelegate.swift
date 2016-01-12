//
//  AppDelegate.swift
//  Track
//
//  Created by Aaron Schubert on 08/01/2016.
//  Copyright © 2016 aaronschubert. All rights reserved.
//

import UIKit

var recorder = Recorder(previousActions: [])
let textView = UITextView()
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        textView.frame = CGRectMake(0, CGRectGetHeight((window?.frame)!)-300, CGRectGetWidth((window?.frame)!), 300)
        textView.backgroundColor = UIColor.blackColor()
        textView.textColor = UIColor.whiteColor()
        textView.font = UIFont.boldSystemFontOfSize(UIFont.smallSystemFontSize())
        let root = ViewController()
        window?.rootViewController = UINavigationController(rootViewController: root)
        window?.makeKeyAndVisible()
        if let savedActions = userDefaults.objectForKey("recordings") {
            let allDictionaryActions = savedActions as! [[String:AnyObject]]
            var allActions = [Action]()
            for dictionary in allDictionaryActions {
                allActions.append(Action(dictionary: dictionary))
            }
            recorder.replayActions(allActions, rootViewController: root)
        }
        
//        let firstAction = Action(identifier: "ViewController", action: ViewControllerActions.Next, delay: true)
//        let secondAction = Action(identifier: "SecondViewController", action: SecondViewControllerActions.Next, delay: true)
//        let thirdAction = Action(identifier: "SecondViewController", action: GlobalActions.Pop, delay: true)
//        recorder.replayActions([firstAction,secondAction,thirdAction], rootViewController: root)
        window?.addSubview(textView)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        recorder.save()
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        recorder.save()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        recorder.save()
    }
    
    
    func topViewController() -> UIViewController
    {
        return topViewControllerWith((UIApplication.sharedApplication().keyWindow?.rootViewController)!)
    }
    
    func topViewControllerWith(rootViewController: UIViewController) -> UIViewController
    {
        if rootViewController is UITabBarController {
            let tabBarController = rootViewController as! UITabBarController
            return topViewControllerWith(tabBarController.selectedViewController!)
        }
        else if rootViewController is UINavigationController {
            let navigationController = rootViewController as! UINavigationController
            return topViewControllerWith(navigationController.visibleViewController!)
        }
        else if rootViewController.presentedViewController != nil {
            let presentedViewController = rootViewController.presentedViewController
            return topViewControllerWith(presentedViewController!)
        }
        else {
            return rootViewController
        }
    }
    
}

