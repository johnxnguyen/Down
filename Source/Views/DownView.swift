//
//  DownView.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import WebKit

// MARK: - Public API

public class DownView: WKWebView {

    /**
     Initializes a web view with the results of rendering a CommonMark Markdown string

     - parameter frame:              The frame size of the web view
     - parameter markdownString:     A string containing CommonMark Markdown
     - parameter openLinksInBrowser: Whether or not to open links using an external browser

     - returns: An instance of Self
     */
    @warn_unused_result
    public init(frame: CGRect, markdownString: String, openLinksInBrowser: Bool = true) throws {
        super.init(frame: frame, configuration: WKWebViewConfiguration())

        if openLinksInBrowser { navigationDelegate = self }
        try loadHTMLView(markdownString)
    }

    // MARK: - Private Properties

    private let bundle: NSBundle = {
        let bundle = NSBundle(forClass: DownView.self)
        let url = bundle.URLForResource("DownView", withExtension: "bundle")!
        return NSBundle(URL: url)!
    }()

    private lazy var baseURL: NSURL = {
        return self.bundle.URLForResource("index", withExtension: "html")!
    }()
}

// MARK: - Private API

private extension DownView {

    func loadHTMLView(markdownString: String) throws {
        let htmlString = try markdownString.toHTML()
        let pageHTMLString = try htmlFromTemplate(htmlString)
        loadHTMLString(pageHTMLString, baseURL: baseURL)
    }

    func htmlFromTemplate(htmlString: String) throws -> String {
        let template = try NSString(contentsOfURL: baseURL, encoding: NSUTF8StringEncoding)
        return template.stringByReplacingOccurrencesOfString("DOWN_HTML", withString: htmlString)
    }

}

// MARK: - WKNavigationDelegate

extension DownView: WKNavigationDelegate {

    public func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.URL else { return }

        switch navigationAction.navigationType {
        case .LinkActivated:
            decisionHandler(.Cancel)
            UIApplication.sharedApplication().openURL(url)
        default:
            decisionHandler(.Allow)
        }
    }
    
}