//
//  CreateMemoViewController.swift
//  voicy-ios
//
//  Created by Eliel A. Gordon on 1/5/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class CreateMemoViewController: UIViewController {
    let audioHandler = AudioHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let outPutUrl = audioHandler.prepareRecorder()
        
    }
}
