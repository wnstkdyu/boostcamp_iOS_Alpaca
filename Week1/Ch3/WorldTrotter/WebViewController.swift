//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Alpaca on 2017. 7. 1..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var webView: UIWebView!
    
    override func loadView() {
        
        webView = UIWebView()
        
        view = webView
        if let url = URL(string: "https://www.bignerdranch.com") {
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WebViewController loaded its view.")
    }
    
    
}
