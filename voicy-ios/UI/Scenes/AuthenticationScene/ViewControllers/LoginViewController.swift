//
//  LoginViewController.swift
//  voicy-ios
//
//  Created by Eliel A. Gordon on 1/5/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let keychain = KeychainSwift()
    let userDefaults = UserDefaults.standard
    var status: Int = 0

    @IBAction func loginPressed(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
    
        VoiceyHTTPClient.instance.request(route: .getUser, data: nil) { user in
//            let userInfo = try? JSONDecoder().decode(User.self, from: user)
//            guard let token = userInfo?.token else {return}
//            self.keychain.set(token, forKey: "Token")
            
        }
        status = userDefaults.object(forKey: "status") as! Int
        authorize()
      
    }
    
    func authorize() {
        if status == 200 {
            AppDelegateViewModel.instance.changeStatus(authStatus: .authorized)
           
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
