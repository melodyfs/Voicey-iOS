//
//  VoiceyHTTPClient.swift
//  voicy-ios
//
//  Created by Eliel A. Gordon on 1/5/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation
import KeychainSwift

typealias NetworkCallback = (String) -> ()

enum Route {
    case createUser
    case getUser
    case createMemo
    case getMemo
    
    func path() -> String {
        switch self {
        case .createUser, .getUser:
            return "users"
        case .createMemo, .getMemo:
            return "memos"
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .createUser:
            return [:]
        default:
            return ["Authorization": "Token token=1da5290ffece78c8410ce04ebdf0f0d8"]
        }
    }
    
    func body(data: Encodable?) -> Data?  {
        let encoder = JSONEncoder()
        
        switch self {
        case .createUser:
            guard let model = data as? User else {return nil}
            let result = try? encoder.encode(model)
            return result
        case .createMemo:
            guard let model = data as? Memo else {return nil}
            let result = try? encoder.encode(model)
            return result
        default:
            return nil
        }
    }
    
    func method() -> String {
        switch self {
        case .createUser, .createMemo:
            return "POST"
        default:
            return "GET"
        }
    }
    
}

class VoiceyHTTPClient {
    
    static let instance = VoiceyHTTPClient()
    let userDefaults = UserDefaults.standard
    
    let session = URLSession.shared
    let base = "https://voicey-app.herokuapp.com/"
    
//    func request(callback: NetworkCallback) {
    func request(route: Route, data: Encodable?, completion: @escaping (Data) -> Void) {
        let fullURL = base.appending(route.path())
        let url = URL(string: fullURL)
        
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = route.headers()
        request.httpBody = route.body(data: data)
        request.httpMethod = route.method()
        
        session.dataTask(with: request) { (data, res, err) in
            let httpResponse = res as? HTTPURLResponse
            if let data = data {
                completion(data)
                print("Networking succeeded")
                let statusCode = (httpResponse?.statusCode)!
                self.userDefaults.set(statusCode, forKey: "status")
                print(statusCode)
            }
            else {
                print(err?.localizedDescription ?? "Error")
            }
        }.resume()
        
//        callback("")
    }
}
