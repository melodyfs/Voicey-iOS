//
//  AppDelegateViewModel.swift
//  voicy-ios
//
//  Created by Melody on 1/19/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation
import UIKit

enum AuthStatus {
    case authorized
    case unauthorized
    
}

typealias RootCallback = (_ viewController: UIViewController) -> Void

class AppDelegateViewModel {
    static let instance = AppDelegateViewModel()
    let keys = AppKeys.instance
    let rootViewController: UIViewController
    var authStatus: AuthStatus = .unauthorized
    var rootCallback: RootCallback?
    
    //remove observer
    deinit {
        NotificationCenter
            .default
            .removeObserver(self, name: Notification.Name("authorized"), object: nil)
    }
    
    init() {
        
        authStatus = keys.isLoggedIn ? .authorized : .unauthorized
        
        switch authStatus {
        case .authorized:
            rootViewController = MemoListViewController(
                nibName: MemoListViewController.storyboardIdentifier,
                bundle: Bundle.main
            )
        case .unauthorized:
            rootViewController = LoginViewController(
                nibName: LoginViewController.storyboardIdentifier,
                bundle: Bundle.main
            )
            
        }
        
        //recieve notification
        NotificationCenter
            .default
            .addObserver(
                forName: Notification.Name("authorized"),
                object: nil,
                queue: nil,
                using: changeRootViewController
        )
        
    }
    
    //switch root view controller after recieving the notification
    @objc func changeRootViewController(notification: Notification) {
        guard let authStatus = notification.object as? AuthStatus,
            let rootCallback = rootCallback
            else {return}
        
        var rootViewController: UIViewController
        
        switch authStatus {
        case .authorized:
            rootViewController = MemoListViewController(
                nibName: MemoListViewController.storyboardIdentifier,
                bundle: Bundle.main
            )
        case .unauthorized:
            rootViewController = LoginViewController(
                nibName: LoginViewController.storyboardIdentifier,
                bundle: Bundle.main
            )
            
        }
        
        rootCallback(rootViewController)
    }
    
    func changeStatus(authStatus: AuthStatus) {
        self.authStatus = authStatus
        //post notification
        NotificationCenter.default.post(
            name: Notification.Name("authorized"),
            object: authStatus
        )
    }
}
