//
//  WebViewController.swift
//  Repositories_Search
//
//  Created by Starly.Chen on 11/1/23.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    private let webViewContainer = UIView()
    lazy var webView: WKWebView = {
        let configurations = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: configurations)
        webview.uiDelegate = self
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.view.addSubview(webViewContainer)
        webViewContainer.backgroundColor = .red
        webViewContainer.addSubview(webView)
        webViewContainer.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            webViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            webViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: self.webViewContainer.leadingAnchor),
            webView.topAnchor.constraint(equalTo: self.webViewContainer.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.webViewContainer.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: self.webViewContainer.trailingAnchor),
        ])
        
            
        DispatchQueue.main.async {
            let myURL = URL(string:"https://www.apple.com")
            let myRequest = URLRequest(url: myURL!)
            self.webView.load(myRequest)
        }
        
        
       
    }
}
