//
//  VoiceyHTTPClient.swift
//  voicy-ios
//
//  Created by Eliel A. Gordon on 1/5/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation

typealias NetworkCallback = (String) -> ()
class VoiceyHTTPClient {
    
    
    static let instance = VoiceyHTTPClient()
    
    func request(callback: NetworkCallback) {
        callback("")
    }
}
