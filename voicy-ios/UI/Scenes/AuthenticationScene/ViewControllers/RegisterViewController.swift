//
//  RegisterViewController.swift
//  voicy-ios
//
//  Created by Eliel A. Gordon on 1/5/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit
import KeychainSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        let name = nameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        let newUser = User(name: name, email: email, password: password, token: nil)
        
        VoiceyHTTPClient.instance.request(route: .createUser, data: newUser) { _ in}
        
    }
}
