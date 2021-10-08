//
//  WebViewController.swift
//  XYNav_Example
//
//  Created by 渠晓友 on 2021/9/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {

    var webView: WKWebView?
    var indicateLabel = UILabel()
    var spinnerView = UIActivityIndicatorView(style: .gray)
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: self.view.bounds)
        webView!.autoresizingMask = UIView.AutoresizingMask(arrayLiteral: .flexibleWidth,.flexibleHeight)
        webView!.navigationDelegate = self
        webView!.allowsBackForwardNavigationGestures = true
        view.addSubview(webView!)
        
        indicateLabel.font = UIFont.systemFont(ofSize: 14)
        indicateLabel.textColor = .white
        indicateLabel.numberOfLines = 2
        indicateLabel.textAlignment = .center
        indicateLabel.text = "Site provided by:\n"
        indicateLabel.sizeToFit()
        indicateLabel.translatesAutoresizingMaskIntoConstraints = false
        webView!.insertSubview(indicateLabel, belowSubview: webView!.scrollView)
        
        let topCons = NSLayoutConstraint(item: indicateLabel, attribute: .top, relatedBy: .equal, toItem: webView!, attribute: .top, multiplier: 1.0, constant: 16)
        let centerXCons = NSLayoutConstraint(item: indicateLabel, attribute: .centerX, relatedBy: .equal, toItem: webView!, attribute: .centerX, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([topCons,centerXCons])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.red
        self.navigationController?.isToolbarHidden = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinnerView)
        
        let backward = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(onBackward))
        
        let forward = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(onForward))
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onRefresh))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onShare))
        
        self.toolbarItems = [
            backward,
            itemFlexSpace(),
            forward,
            itemFlexSpace(),
            refresh,
            itemFlexSpace(),
            share
        ]
        
        if #available(iOS 15.0, *) {
            let appearance = UIToolbarAppearance()
            appearance.backgroundColor = UIColor.systemBackground
            self.navigationController?.toolbar.scrollEdgeAppearance = appearance
        } else {}
        webView!.load(URLRequest(url: URL(string: "https://www.baidu.com")!))
    }
    
    func itemFlexSpace() -> UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    
    // MARK: - actions
    @objc func onBackward() {
        webView!.goBack()
    }
    
    @objc func onForward() {
        webView!.goForward()
    }
    
    @objc func onRefresh() {
        webView!.reload()
    }
    
    @objc func onShare() {
    }
}


extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinnerView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinnerView.startAnimating()
        indicateLabel.text = "Site provided by:" + (webView.url?.host ?? "")
        self.title = webView.title
        
        self.toolbarItems?[0].isEnabled = webView.canGoBack
        self.toolbarItems?[2].isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinnerView.stopAnimating()
    }
}
