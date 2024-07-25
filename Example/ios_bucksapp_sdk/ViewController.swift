//
//  ViewController.swift
//  ios_bucksapp_sdk
//
//  Created by Raul on 03/14/2022.
//  Copyright (c) 2022 Raul. All rights reserved.
//

import UIKit
import WebKit
import ios_bucksapp_sdk

class ViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bucksapp = Bucksapp(
            apiKey: "HYtaiwHX12yvJzmihnUwng",
            uuid: "0204d823-4d2e-4a54-8f33-0167e3c04ff5",
            environment: "sandbox",
            webView: webview
        )

        bucksapp.generateRequest()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
