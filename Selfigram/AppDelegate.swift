//
//  AppDelegate.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-05-12.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import UIKit
import Parse


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Post.registerSubclass()
        Activity.registerSubclass()
        
        //Parse.setApplicationId("ZOlS6FOiiSLf52E273Aeo2GCNExc5a0F0tPftmjI", clientKey: "XcvfY61gfyyxZCObodvYgLJIhTWd0a0aU0QeKZeb")
        //Parse.setApplicationId("5CDeHX2xNhW11QZXr9AvtBbEQY0lft4jpUuMFt9g", clientKey: "SO1UFKR9k8RsLx1FsXzBjyI6IjsKxm2K0jcm48dG")
        
        //Heroku Deployment:
        let config = ParseClientConfiguration(block: {
            (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = "1062shaw";
            ParseMutableClientConfiguration.clientKey = "hello999";
            ParseMutableClientConfiguration.server = "https://selfigram-002.herokuapp.com/parse";
        });
        
        Parse.initializeWithConfiguration(config);

        
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            if success {
//                print("Object has been saved.")
//            }
//        }
        
        
        let user = PFUser()
        let username = "shawn"
        let password = "crisp"
        user.username = username
        user.password = password
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if success {
                print("successfully signed up a user")
            }else {
                PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                    if let user = user {
                        print("successfully logged in \(user)")
                    }
                })
            }
        }
        
        
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

