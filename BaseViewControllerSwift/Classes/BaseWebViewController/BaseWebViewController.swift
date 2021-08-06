//
//  BaseWebViewController.swift
//  BaseViewControllerSwift
//
//  Created by Sumansoul on 2021/8/4.
//

import UIKit
import WebKit

open class BaseWebViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate , WKScriptMessageHandler, UIGestureRecognizerDelegate {

    var webView : WKWebView!
    
    var progress : UIProgressView!
    
    var lastProgress : Double = 0.0;
    
    public var needObservedTitle : Bool = true
    
    var progressViewColor : UIColor?{
        didSet
        {
            self.progress?.tintColor = progressViewColor
        }
    }
    
    var webConfiguration : WKWebViewConfiguration?
    
    public var url : String?
    
    public var jsEvalutionJson : String?
    
    open func webviewDidLoadFinished(webView : WKWebView) -> Void {
        
    }
    
    open func webViewDidFailed(webView : WKWebView , error : Error) -> Void {
        
    }
    
    open func webViewDidReceived(message : WKScriptMessage) -> Void {
    
    }
    
    open func webViewNavigatorWith(url : URL) -> WKNavigationActionPolicy {
        return .allow
    }
    
    open func clickBackButton(webView : WKWebView) -> Void {
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate? = self
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        setupUIInterface()

        setupData()
        
        // Do any additional setup after loading the view.
    }
    
    func setupUIInterface() -> Void {
        
        self.shouldHiddenNavigationBar = false
        self.shouldShowBackButton = true
    
        let configuration : WKWebViewConfiguration = WKWebViewConfiguration.init()
        configuration.preferences.javaScriptEnabled = true
        
        self.webView = WKWebView.init(frame: CGRect.init(x: 0, y: kNavigationBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - kNavigationBarHeight), configuration: configuration)
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.allowsBackForwardNavigationGestures = false
        self.webView.backgroundColor = UIColor.clear
        self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        if #available(iOS 11.0, *)
        {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(self.webView)
        
        self.progress = UIProgressView.init(progressViewStyle: UIProgressViewStyle.default)
        self.progress.tintColor = self.progressViewColor
        self.progress.trackTintColor = UIColor.clear
        self.progress.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 3.0)
        self.webView.addSubview(self.progress)
    }
    
    func setupData() -> Void {
        self.webView.stopLoading()
        self.webView.load(URLRequest.init(url: URL.init(string: url!)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0))
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        switch keyPath {
        case "title":
            self.navigationItem.title = self.webView.title
        case "estimatedProgress":
            self.updateProgressValue(progress: self.webView.estimatedProgress)
        case .none:    break
        case .some(_): break
        }

    }
    
    func updateProgressValue(progress : Double) -> Void {
        self.progress.alpha = 1.0;
        
        if (progress > self.lastProgress)
        {
            self.progress.setProgress(Float(progress), animated: true)
        }
        else
        {
            self.progress.progress = Float(progress)
        }
        
        self.lastProgress = progress
        
        if (progress > 1.0)
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.progress.alpha = 0.0
                self.progress.progress = 0.0
                self.lastProgress = 0.0
            }
        }
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let tmpJsEvalutionJson = self.jsEvalutionJson , tmpJsEvalutionJson.count > 0
        {
            self.webView.evaluateJavaScript(tmpJsEvalutionJson) { (data : Any?, error : Error?) in
                self.jsEvalutionJson = ""
            }
        }
        
        self.updateProgressValue(progress: webView.estimatedProgress)
        
        self.webviewDidLoadFinished(webView: webView)
    }
    
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if (self.webView != webView)
        {
            decisionHandler(.allow)
            return
        }
        
        let url = self.webView.url
        switch url?.scheme {
            case "tel" , "itunes.apple.com":
            if (UIApplication.shared.canOpenURL(url!))
            {
                UIApplication.shared.openURL(url!)
            }
            decisionHandler(.cancel)
            return
            default:
                break
        }
        
        decisionHandler(webViewNavigatorWith(url: url!))
    }
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if (navigationAction.targetFrame?.isMainFrame == false)
        {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.progress.setProgress(0.0, animated: false)
        
        webViewDidFailed(webView: webView, error: error)
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self .webViewDidReceived(message: message)
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    deinit {
        self.webView.navigationDelegate = nil
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
        if (self.needObservedTitle)
        {
            self.webView.removeObserver(self, forKeyPath: "title")
        }
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
