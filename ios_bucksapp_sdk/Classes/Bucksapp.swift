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

final public class Bucksapp : UIViewController {
    
    let webView:WKWebView =  WKWebView()
    public var apiKey:String = "";
    public var uuid:String = "";
    public var environment:String = "development";
    var host:String {
        switch environment {
        case "staging": return "app.stg.bucksapp.com"
        case "sandbox": return "app.sbx.bucksapp.com"
        case "production": return "app.wally.bucksapp.com"
        default: return "app.dev.bucksapp.com"
        }
    };
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        authenticateAndLoadWebView()
    }
    
    private func authenticateAndLoadWebView() {
        guard let url = URL(string: "https://\(host)/api/authenticate") else { return }
        
        let parameters: [String: Any] = ["user": uuid]
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        
        //        let parameters = "{\n    \"user\": \"\(uuid)\"\n}"
        //        let postData = parameters.data(using: .utf8)
        
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
                self.showError("Error occurred: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                self.showError("No data received: \(String(describing: error))")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
                  let token = json["token"] as? String else {
                self.showError("Invalid JSON received or no token found.")
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
    
    private func showError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
}
