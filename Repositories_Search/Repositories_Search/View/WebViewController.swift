//
//  WebViewController.swift
//  Repositories_Search
//
//  Created by Starly.Chen on 11/1/23.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    var viewModel: ViewModel?
    private let webViewContainer = UIView()
    private let closeButton = UIButton()
    lazy var webView: WKWebView = {
        let configurations = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: configurations)
        webview.uiDelegate = self
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }

        setupViews()
        setupHierarchy()
        setupConstraints()
        
        DispatchQueue.main.async {
            let request = URLRequest(url: viewModel.url)
            self.webView.load(request)
        }
    }

    func setupViews() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        webViewContainer.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.setImage(UIImage(named: "ic_close"), for: .normal)
    }
    
    
    
    func setupHierarchy() {
        self.view.addSubview(webViewContainer)
        webViewContainer.addSubview(webView)
        self.view.addSubview(closeButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            closeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44),
            closeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1)
        ])
        
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
    }
    
    @objc func close() {
        self.dismiss(animated: true)
    }
}

extension WebViewController {
    struct ViewModel {
        var url: URL
    }
}
