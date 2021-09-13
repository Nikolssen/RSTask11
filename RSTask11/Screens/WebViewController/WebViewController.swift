//
//  WebViewController.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/13/21.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var backBarButtonItem: UIBarButtonItem!
    @IBOutlet var forwardBarButtonItem: UIBarButtonItem!
    @IBOutlet var shareBarButtonItem: UIBarButtonItem!
    @IBOutlet var safariBarButtonItem: UIBarButtonItem!
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            webView.load(URLRequest(url: url))
        }
        backBarButtonItem.isEnabled = false
        forwardBarButtonItem.isEnabled = false
        configureNavigationBar()
        webView.navigationDelegate = self
        
    }

    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
        if !webView.canGoBack {
            backBarButtonItem.isEnabled = false
        }
    }
    
    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
        if !webView.canGoForward {
          forwardBarButtonItem.isEnabled = false
        }
    }
    
    @IBAction func share(_ sender: Any) {
        guard let url = webView.url else { return }
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func openSafari(_ sender: Any) {
        guard let url = webView.url else { return }
        
        UIApplication.shared.open(url)
    }
    
    func configureNavigationBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .roundArrow, style: .plain, target: self, action: #selector(updatePage))
    }

    @objc func updatePage(){
        navigationItem.rightBarButtonItem?.isEnabled = false
        webView.reload()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.addObserver(self, forKeyPath: "isLoading", options: [.initial, .new], context: nil)
        webView.addObserver(self, forKeyPath: "backForwardList", options: [.new], context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: "isLoading")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath{
            if keyPath == "isLoading" {
                navigationItem.rightBarButtonItem?.isEnabled = !webView.isLoading
            }
        }
        
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        backBarButtonItem.isEnabled = (webView.backForwardList.backItem != nil)
        forwardBarButtonItem.isEnabled = (webView.backForwardList.forwardItem != nil)
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}
