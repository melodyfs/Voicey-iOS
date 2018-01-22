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

class AppDelegateViewModel {
    static let instance = AppDelegateViewModel()
    let keys = AppKeys.instance
    let rootViewController: UIViewController
    var authStatus: AuthStatus = .unauthorized
    
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
    }
    
    // TODO: use notification to alert the change of status
    func changeStatus(authStatus: AuthStatus) {
        self.authStatus = authStatus
    }
}
