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

final public class Bucksapp {
    
    public var apiKey:String = "";
    public var uuid:String = "";
    public var environment:String = "development";
    let webView:WKWebView;
    var host:String {
        switch environment {
        case "staging": return "app.stg.bucksapp.com"
        case "sandbox": return "app.sbx.bucksapp.com"
        case "production": return "app.wally.bucksapp.com"
        default: return "app.dev.bucksapp.com"
        }
    };
    
    public init(apiKey: String, uuid: String, environment: String, webView: WKWebView) {
        self.apiKey = apiKey
        self.uuid = uuid
        self.environment = environment
        self.webView = webView
    }
    
    public func generateRequest() {
        guard let url = URL(string: "https://\(host)/api/authenticate") else { return }
        
        let parameters: [String: Any] = ["user": uuid]
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}

        var request = URLRequest(url: url,timeoutInterval: Double.infinity);
        request.addValue(environment, forHTTPHeaderField: "jwt_aud")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-API-KEY")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received: \(String(describing: error))")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
                  let token = json["token"] as? String else {
                print("Invalid JSON received or no token found.")
                return
            }
            self.loadWebView(with: token)
            
        }
        task.resume()

    }
    
    private func loadWebView(with token:String){
        guard let url = URL(string: "https://\(host)/api/home") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = ["token": token]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }
}
