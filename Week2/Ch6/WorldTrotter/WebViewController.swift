//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Alpaca on 2017. 7. 9..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webview: WKWebView!
    
    override func loadView() {
        
        webview = WKWebView()
        self.view = webview
        
        let url = URL(string: "https://www.bignerdranch.com")
        if let url = url {
            let urlRequest = URLRequest(url: url)
            webview.load(urlRequest)
        }
        print("Load webView")
        
    }

}
