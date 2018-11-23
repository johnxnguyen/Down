//
//  DownViewTests.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

#if os(tvOS)
    // Sorry, not available for tvOS
#else
import XCTest
import WebKit
@testable import Down

class DownViewTests: XCTestCase {

    func testInstantiation() {
        let expect1 = expectation(description: "DownView sets the html and validates the html is correct")
        var downView: DownView?
        downView = try? DownView(frame: .zero, markdownString: "## [Down](https://github.com/iwasrobbed/Down)", didLoadSuccessfully: {
            self._pageContents(for: downView!) { (htmlString) in
                XCTAssertTrue(htmlString!.contains("css/down.min.css"))
                XCTAssertTrue(htmlString!.contains("https://github.com/iwasrobbed/Down"))
                
                expect1.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testUpdatingMarkdown() {
        let expect1 = expectation(description: "DownView sets the html and validates the html is correct")
        var downView: DownView?
        downView = try? DownView(frame: .zero, markdownString: "## [Down](https://github.com/iwasrobbed/Down)") {
            self._pageContents(for: downView!) { (htmlString) in
                XCTAssertTrue(htmlString!.contains("css/down.min.css"))
                XCTAssertTrue(htmlString!.contains("https://github.com/iwasrobbed/Down"))
                
                expect1.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
        let expect2 = expectation(description: "DownView sets the html and validates the html is correct")
        try? downView?.update(markdownString:  "## [Google](https://google.com)") {
            self._pageContents(for: downView!) { (htmlString) in
                XCTAssertTrue(htmlString!.contains("css/down.min.css"))
                XCTAssertTrue(htmlString!.contains("https://google.com"))
                
                expect2.fulfill()
            }
        }
    
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testInstantiationWithCustomTemplateBundle() {
        let expect1 = expectation(description: "DownView accepts and uses a custom theme bundle")
        guard
            let bundle = Bundle(for: type(of: self)).url(forResource: "TestDownView", withExtension: "bundle"),
            let templateBundle = Bundle(url: bundle)
        else {
            XCTFail("Test template bundle not found in test target!")
            return
        }

        var downView: DownView?
        downView = try? DownView(frame: .zero, markdownString: "## [Down](https://github.com/iwasrobbed/Down)", templateBundle: templateBundle, didLoadSuccessfully: {
            self._pageContents(for: downView!) { (htmlString) in
                XCTAssertTrue(htmlString!.contains("css/down.min.css"))
                XCTAssertTrue(htmlString!.contains("https://github.com/iwasrobbed/Down"))
                XCTAssertTrue(htmlString!.contains("But also, custom HTML!"))

                expect1.fulfill()
            }
        })

        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    @available(iOS 11.0, macOS 10.13, *)
    func testCustomURLSchemeHandler() {
        let mockURLScheme = "down"
        let mockURL = URL(string: "down://test")!
        let expectation = self.expectation(description: "DownView supports custom URL handlers.")
        var downView: DownView?

        class MockURLSchemeHandler: NSObject, WKURLSchemeHandler {
            var mockURL: URL!
            var testExpectation: XCTestExpectation!

            func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
                guard urlSchemeTask.request.url == mockURL else {
                    XCTFail("URL scheme task request has invalid URL.")
                    return
                }

                testExpectation.fulfill()
            }

            func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {}
        }

        func didLoadSuccessfully() {
            downView?.evaluateJavaScript("document.links[0].click();", completionHandler: { (_, error) in
                if let error = error {
                    XCTFail("JavaScript evaluation error: '\(error.localizedDescription)'")
                }
            })
        }

        let mockURLSchemeHandler = MockURLSchemeHandler()
        mockURLSchemeHandler.mockURL = mockURL
        mockURLSchemeHandler.testExpectation = expectation

        let configuration = WKWebViewConfiguration()
        configuration.setURLSchemeHandler(mockURLSchemeHandler, forURLScheme: mockURLScheme)

        downView = try? DownView(frame: .zero, markdownString: "[Link](\(mockURL.absoluteString))", openLinksInBrowser: true, configuration: configuration, didLoadSuccessfully: didLoadSuccessfully)

        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}

fileprivate extension DownViewTests {
    
    func _pageContents(for downView: DownView, completion: @escaping (_ htmlString: String?) -> ()) {
        downView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html: Any?, _) in
            completion(html as? String)
        }
    }
    
}
#endif
