//
//  DownView.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

#if os(tvOS) || os(watchOS)
    // Sorry, not available for tvOS nor watchOS
#else
import WebKit

// MARK: - Public API

public typealias DownViewClosure = () -> ()

open class DownView: WKWebView {

    /**
     Initializes a web view with the results of rendering a CommonMark Markdown string

     - parameter frame:               The frame size of the web view
     - parameter markdownString:      A string containing CommonMark Markdown
     - parameter openLinksInBrowser:  Whether or not to open links using an external browser
     - parameter templateBundle:      Optional custom template bundle. Leaving this as `nil` will use the bundle included with Down.
     - parameter configuration:       Optional custom web view configuration.
     - parameter didLoadSuccessfully: Optional callback for when the web content has loaded successfully

     - returns: An instance of Self
     */
    public init(frame: CGRect, markdownString: String, openLinksInBrowser: Bool = true, templateBundle: Bundle? = nil, configuration: WKWebViewConfiguration? = nil, didLoadSuccessfully: DownViewClosure? = nil) throws {
        self.didLoadSuccessfully = didLoadSuccessfully

        if let templateBundle = templateBundle {
            self.bundle = templateBundle
        } else {
            let classBundle = Bundle(for: DownView.self)
            let url = classBundle.url(forResource: "DownView", withExtension: "bundle")!
            self.bundle = Bundle(url: url)!
        }

        super.init(frame: frame, configuration: configuration ?? WKWebViewConfiguration())

        #if os(macOS)
            setupMacEnvironment()
        #endif

        if openLinksInBrowser || didLoadSuccessfully != nil { navigationDelegate = self }
        try loadHTMLView(markdownString)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    #if os(macOS)
    deinit {
        clearTemporaryDirectory()
    }
    #endif
    
    // MARK: - API
    
    /**
     Renders the given CommonMark Markdown string into HTML and updates the DownView while keeping the style intact
     
     - parameter markdownString:      A string containing CommonMark Markdown
     - parameter didLoadSuccessfully: Optional callback for when the web content has loaded successfully

     - throws: `DownErrors` depending on the scenario
     */
    public func update(markdownString: String, didLoadSuccessfully: DownViewClosure? = nil) throws {
        // Note: As the init method takes this callback already, we only overwrite it here if
        // a non-nil value is passed in
        if let didLoadSuccessfully = didLoadSuccessfully {
            self.didLoadSuccessfully = didLoadSuccessfully
        }

        try loadHTMLView(markdownString)
    }

    // MARK: - Private Properties

    let bundle: Bundle

    fileprivate lazy var baseURL: URL = {
        return self.bundle.url(forResource: "index", withExtension: "html")!
    }()

    #if os(macOS)
    fileprivate lazy var temporaryDirectoryURL: URL = {
        return try! FileManager.default.url(for: .itemReplacementDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: URL(fileURLWithPath: "/"),
                                            create: true).appendingPathComponent("Down", isDirectory: true)
    }()
    #endif
    
    fileprivate var didLoadSuccessfully: DownViewClosure?
}

// MARK: - Private API

private extension DownView {

    func loadHTMLView(_ markdownString: String) throws {
        let htmlString = try markdownString.toHTML()
        let pageHTMLString = try htmlFromTemplate(htmlString)

        #if os(iOS)
            loadHTMLString(pageHTMLString, baseURL: baseURL)
        #elseif os(macOS)
            let indexURL = try createTemporaryBundle(pageHTMLString: pageHTMLString)
            loadFileURL(indexURL, allowingReadAccessTo: indexURL.deletingLastPathComponent())
        #endif
    }

    func htmlFromTemplate(_ htmlString: String) throws -> String {
        let template = try String(contentsOf: baseURL, encoding: .utf8)
        return template.replacingOccurrences(of: "DOWN_HTML", with: htmlString)
    }

    #if os(macOS)
    func createTemporaryBundle(pageHTMLString: String) throws -> URL {
        guard let bundleResourceURL = bundle.resourceURL
            else { throw DownErrors.nonStandardBundleFormatError }
        let indexURL = temporaryDirectoryURL.appendingPathComponent("index.html", isDirectory: false)

        // If updating markdown contents, no need to re-copy bundle.
        if !FileManager.default.fileExists(atPath: indexURL.path) {
            // Copy bundle resources to temporary location.
            try FileManager.default.copyItem(at: bundleResourceURL, to: temporaryDirectoryURL)
        }

        // Write generated index.html to temporary location.
        try pageHTMLString.write(to: indexURL, atomically: true, encoding: .utf8)

        return indexURL
    }

    func setupMacEnvironment() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearTemporaryDirectory),
                                               name: NSApplication.willTerminateNotification,
                                               object: nil)
    }

    @objc
    func clearTemporaryDirectory() {
        try? FileManager.default.removeItem(at: temporaryDirectoryURL)
    }
    #endif

}

// MARK: - WKNavigationDelegate

extension DownView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return decisionHandler(.allow) }

        switch navigationAction.navigationType {
        case .linkActivated:
            if #available(iOS 11.0, macOS 10.13, *) {
                if let scheme = url.scheme, configuration.urlSchemeHandler(forURLScheme: scheme) != nil {
                    decisionHandler(.allow)
                    return
                }
            }

            decisionHandler(.cancel)
            #if os(iOS)
                UIApplication.shared.openURL(url)
            #elseif os(macOS)
                NSWorkspace.shared.open(url)
            #endif
        default:
            decisionHandler(.allow)
        }
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didLoadSuccessfully?()
    }
    
}
#endif
