//
//  ViewController.swift
//  WebView
//
//  Created by allbino_mac on 2020/02/21.
//  Copyright © 2020 allbino. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate{

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"http://127.0.0.1:8081/login")
        let myRequest = URLRequest(url: myURL!)
        let statusBarRect = UIApplication.shared.statusBarFrame
        let height = statusBarRect.height
        print(height)
        webView.load(myRequest)
    }

//    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
//        let completionHandlerWrapper = CompletionHandlerWrapper(completionHandler: completionHandler, defaultValue: Void())
//        /* custom UI */
//    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert); let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in completionHandler() }; alertController.addAction(cancelAction); DispatchQueue.main.async { self.present(alertController, animated: true, completion: nil) }
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
      let completionHandlerWrapper = CompletionHandlerWrapper(completionHandler: completionHandler, defaultValue: false)
      let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "확인", style: .default) { _ in completionHandlerWrapper.respondHandler(true) })
      alertController.addAction(UIAlertAction(title: "취소", style: .cancel) { _ in completionHandlerWrapper.respondHandler(false) })
      present(alertController, animated: true, completion: nil)
    }
}

class CompletionHandlerWrapper<Element> {
  private var completionHandler: ((Element) -> Void)?
  private let defaultValue: Element

  init(completionHandler: @escaping ((Element) -> Void), defaultValue: Element) {
    self.completionHandler = completionHandler
    self.defaultValue = defaultValue
  }

  func respondHandler(_ value: Element) {
    completionHandler?(value)
    completionHandler = nil
  }

  deinit {
    respondHandler(defaultValue)
  }
}

