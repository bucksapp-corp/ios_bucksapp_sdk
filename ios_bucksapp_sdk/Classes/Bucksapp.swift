//
//  Bucksapp.swift
//  ios_bucksapp_sdk
//
//  Created by Raúl on 2022-03-14.
//

import Foundation
import WebKit

public class Bucksapp : UIViewController {
    
    let webView:WKWebView =  WKWebView()
    let apiKey:String = "";
    let uuid:String = "";
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://app.dev.bucksapp.com") else {
            return
        }
        let cookie = HTTPCookie(properties: [
            .domain: "app.dev.bucksapp.com",
            .path: "/",
            .name: "NEXT_LOCALE",
            .value: "es",
            .secure: "TRUE",
            .expires: NSDate(timeIntervalSinceNow: 31556926)
        ])!
        
        if #available(iOS 11.0, *) {
            webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
        } else {
            // Fallback on earlier versions
        }
        
        let request:URLRequest = URLRequest(url: url)
        
        webView.load(request)
    
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
}
