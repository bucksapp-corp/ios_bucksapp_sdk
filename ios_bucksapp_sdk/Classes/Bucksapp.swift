//
//  Bucksapp.swift
//  ios_bucksapp_sdk
//
//  Created by Raúl on 2022-03-14.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import WebKit

public class Bucksapp : UIViewController {
    
    let webView:WKWebView =  WKWebView()
    public var apiKey:String = "";
    public var uuid:String = "";
    public var environment:String = "development";
    var host:String = "app.dev.bucksapp.com";
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)

        switch environment {
        case "staging":
            self.host="app.stg.bucksapp.com";
            break;
        case "sandbox":
            self.host="app.sbx.bucksapp.com";
            break;
        case "production":
            self.host="app.bucksapp.com";
            break;
        default:
            self.host="app.dev.bucksapp.com";
        }
        
        let url=URL(string: "https://\(self.host)/api/authenticate");
        
        let parameters = "{\n    \"user\": \"\(uuid)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: url!,timeoutInterval: Double.infinity);
        
        request.addValue(environment, forHTTPHeaderField: "jwt_aud")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-API-KEY")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:AnyObject]
            print(json ?? "Empty Data")
            
            guard let token = json!["token"] else {
                return
            }
            
            guard let url = URL(string: "https://\(self.host)") else {
                return
            }
            
            if #available(iOS 11.0, *) {
                self.webView.configuration.websiteDataStore.httpCookieStore.setCookie(HTTPCookie(properties: [
                    .domain: self.host,
                    .path: "/",
                    .name: "token",
                    .value: token,
                    .secure: "TRUE",
                    .expires: NSDate(timeIntervalSinceNow: 31556926)
                ])!);
                self.webView.configuration.websiteDataStore.httpCookieStore.setCookie(HTTPCookie(properties: [
                    .domain: self.host,
                    .path: "/",
                    .name: "NEXT_LOCALE",
                    .value: "es",
                    .secure: "TRUE",
                    .expires: NSDate(timeIntervalSinceNow: 31556926)
                ])!);
            } else {
                // Fallback on earlier versions
            }
            
            let request:URLRequest = URLRequest(url: url)
            
            self.webView.load(request)
            
            
            
        }
        task.resume()
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
}
