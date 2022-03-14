//
//  Bucksapp.swift
//  ios_bucksapp_sdk
//
//  Created by Raúl on 2022-03-14.
//

import Foundation
import WebKit

public class Bucksapp : UIViewController {
    
    let webView =  WKWebView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://app.dev.bucksapp.com") else {
            return
        }
        
        let request:URLRequest = URLRequest(url: url)
        
        webView.load(request)
    
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
}
