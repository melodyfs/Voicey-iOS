//
//  AppKey.swift
//  voicy-ios
//
//  Created by Melody on 1/19/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation

class AppKeys {
    struct DomainKeys {
        static let loggedIn = "loggedIn"
    }
    
    static let instance = AppKeys()
    private let userDefaults = UserDefaults()
    
    var isLoggedIn: Bool {
        return userDefaults.bool(forKey: DomainKeys.loggedIn)
    }
    
    private init() {}
    
    func set(isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: DomainKeys.loggedIn)
    }
}
