//
//  PrivacyPolicyViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 1/27/24.
//

import UIKit
import SnapKit
import WebKit
import SystemConfiguration

final class PrivacyPolicyViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    // MARK: - UI
    private var webView = WKWebView()
    private var errorView = DownloadErrorView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchWeb()
    }

    // MARK: - Setup Views
    private func setupViews() {
        self.view.addSubview(webView)
        webView.frame = self.view.bounds
        webView.uiDelegate = self
        webView.navigationDelegate = self

        self.view.addSubview(errorView)
        errorView.frame = self.view.bounds
        errorView.isHidden = true
        errorView.backgroundColor = AppColor.beige.uiColor
    }

    // MARK: - Network

    private func fetchWeb() {
        let networkReachability = NetworkReachability()
        if networkReachability.checkNetworkConnection() {
            if let url = URL(string: "https://startios.kz/privacy") {
                let request = URLRequest(url: url)
                webView.load(request)
            } else {
                showDownloadErrorView()
            }
        } else {
            showDownloadErrorView()
        }
    }

    // MARK: - Show Download Error View
    private func showDownloadErrorView() {
        errorView.isHidden = false
        webView.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showDownloadErrorView()
    }
}
