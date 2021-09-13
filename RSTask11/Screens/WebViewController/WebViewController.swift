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
    }

    func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .roundArrow, style: .plain, target: self, action: #selector(updatePage))
    }

    @objc func updatePage(){
        
    }
    
}
