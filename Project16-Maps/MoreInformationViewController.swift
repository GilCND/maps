//
//  MoreInformationViewController.swift
//  Project16-Maps
//
//  Created by Felipe Gil on 2021-08-17.
//

import UIKit
import WebKit

class MoreInformationViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView?
    var urlString: String?
    
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = urlString else { return }
        let url = URL(string: urlString)!
        webView?.load(URLRequest(url: url))
        webView?.allowsBackForwardNavigationGestures = true
    }
}
