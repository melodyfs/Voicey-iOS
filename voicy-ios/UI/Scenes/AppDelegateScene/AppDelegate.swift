//
//  AppDelegate.swift
//  voicy-ios
//
//  Created by Eliel A. Gordon on 1/5/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let viewModel = AppDelegateViewModel.instance
    
    // switch view controller when recieving notification
    func handleRootChange(viewController: UIViewController) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
   
        window = UIWindow(frame: UIScreen.main.bounds)
        viewModel.rootCallback = handleRootChange
        
        window?.rootViewController = viewModel.rootViewController
        window?.makeCorners()
        window?.makeGradient(
            firstColor: UIColor.lighterGreenColor,
            secondColor: UIColor.lightGreenColor
        )
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    
}

