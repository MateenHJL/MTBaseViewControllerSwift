//
//  CommonViewController.swift
//  BaseViewControllerSwift_Example
//
//  Created by Sumansoul on 2021/8/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BaseViewControllerSwift
import WebKit

class CommonViewController: BaseWebViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func webViewDidReceived(message: WKScriptMessage) {
        
    }
    
    override func webViewDidFailed(webView: WKWebView, error: Error) {
        
    }
    
    override func webviewDidLoadFinished(webView: WKWebView) {
    
    }
    
    override func webViewNavigatorWith(url: URL) -> WKNavigationActionPolicy {
        return .allow
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
