//
//  ViewController.swift
//  ios_bucksapp_sdk
//
//  Created by Raul on 03/14/2022.
//  Copyright (c) 2022 Raul. All rights reserved.
//

import UIKit
import ios_bucksapp_sdk

class ViewController: UIViewController {
    
    @IBOutlet weak var vista: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = Bucksapp();
//        vc.apiKey = "09LLLPzuLotX9TwXdRvAqA";
//        vc.uuid = "23c8a70c-416c-4d40-8e2c-9bdfa1fc54fc";
        vc.apiKey = "HYtaiwHX12yvJzmihnUwng";
        vc.uuid = "0204d823-4d2e-4a54-8f33-0167e3c04ff5";
        vc.environment = "sandbox";
        
        vista.addSubview(vc.view);
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
