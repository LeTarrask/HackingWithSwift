//
//  WebViewController.swift
//  Easy Browser
//
//  Created by Alex Luna on 22/04/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url: URL?
    var websites = ["apple.com", "hackingwithswift.com"]

    var progressView: UIProgressView!

    // this must run before viewDidLoad, to prevent webView from crashing
    override func loadView() {
       webView = WKWebView()
       webView.navigationDelegate = self
       view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let loading = url {
            webView.load(URLRequest(url: loading))
        }

        webView.allowsBackForwardNavigationGestures = true

        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:
                                nil, action: nil)
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(goBack))
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(goForward))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, back, forward, refresh]
        navigationController?.isToolbarHidden = false
    }

    @objc func goBack() {
        webView.goBack()
    }

    @objc func goForward() {
        webView.goForward()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                } else {
                    let ac = UIAlertController(title: "Page not allowed", message: "Please don't try to escape from our fence", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
                    present(ac, animated: true)
                    decisionHandler(.cancel)
                }
            }
        }
        decisionHandler(.cancel)
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
