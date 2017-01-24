//
//  AppDelegate.swift
//  GoodBooks
//
//  Created by J1aDong on 2017/1/24.
//  Copyright © 2017年 J1aDong. All rights reserved.
//

import UIKit
import CoreData
import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        let tabbarController = UITabBarController()
        
        let rankController = UINavigationController(rootViewController: rankViewController())
        let searchConroller = UINavigationController(rootViewController: searchViewController())
        let circleController = UINavigationController(rootViewController: circleViewController())
        let pushController = UINavigationController(rootViewController: pushViewController())
        let moreController = UINavigationController(rootViewController: moreViewController())
        
        tabbarController.viewControllers = [rankController,searchConroller,pushController,circleController,moreController]
        
        let tabbarItem1 = UITabBarItem(title: "排行榜", image: UIImage(named: "bio"), selectedImage: UIImage(named: "bio_red"))
        let tabbarItem2 = UITabBarItem(title: "发现", image: UIImage(named: "timer 2"),selectedImage:UIImage(named:"timer 2_red"))
        let tabbarItem3 = UITabBarItem(title: "", image: UIImage(named: "pencil"),selectedImage: UIImage(named: "pencil_red"))
        let tabbarItem4 = UITabBarItem(title: "圈子", image: UIImage(named: "users two-2"),selectedImage:UIImage(named:"users two-2__red"))
        let tabbarItem5 = UITabBarItem(title: "更多", image: UIImage(named: "more"),selectedImage:UIImage(named:"more_red"))
        
        rankController.tabBarItem = tabbarItem1
        searchConroller.tabBarItem = tabbarItem2
        pushController.tabBarItem = tabbarItem3
        circleController.tabBarItem = tabbarItem4
        moreController.tabBarItem = tabbarItem5

        rankController.tabBarController?.tabBar.tintColor = MAIN_RED

        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()
        
        // applicationId 即 App Id，applicationKey 是 App Key
        LeanCloud.initialize(applicationID: "TA9p1dH9HIS1cDaVB8cu33eO-gzGzoHsz", applicationKey: "M0Da93ljH6lN61H3iFGl5Nnr")
        
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GoodBooks")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

