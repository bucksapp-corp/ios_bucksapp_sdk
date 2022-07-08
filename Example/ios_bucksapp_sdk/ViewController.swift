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
        vc.apiKey = "API_KEY";
        vc.uuid = "UUID";
        vc.environment = "sandbox";
        
        vista.addSubview(vc.view);
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
