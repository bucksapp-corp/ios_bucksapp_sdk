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
    
    @IBOutlet weak var showBucksapp: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @IBAction func showBucksappTapped(_ sender: Any) {
        let vc = Bucksapp();
        vc.apiKey = "12TvAswlCh03Qhj5uxiM7w";
        vc.uuid = "1c111bf4-7646-4b84-bc4c-4426fb596a87";
        vc.environment = "development";
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
}
