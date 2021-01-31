//
//  DownViewTests.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016-2019 Down. All rights reserved.
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
            self._pageContents(for: downView!) { htmlString in
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
            self._pageContents(for: downView!) { htmlString in
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
            self._pageContents(for: downView!) { htmlString in
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
            self._pageContents(for: downView!) { htmlString in
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

    func testInstantiationWithCustomWritableTemplateBundle() {
        let expect1 = expectation(description: "DownView accepts and loads custom bundle files from a user writable location")

        guard
            let bundle = Bundle(for: type(of: self)).url(forResource: "TestDownView", withExtension: "bundle"),
            let templateBundle = Bundle(url: bundle)
        else {
            XCTFail("Test template bundle not found in test target!")
            return
        }

        let markdownString = """
```swift
let x = 1
```
"""
        var downView: DownView?
        downView = try? DownView(frame: .zero, markdownString: markdownString, templateBundle: templateBundle, writableBundle: true, didLoadSuccessfully: {
            self._pageContents(for: downView!) { htmlString in
                XCTAssertTrue(htmlString!.contains("css/down.min.css"))
                XCTAssertTrue(htmlString!.contains("hljs-keyword"))
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

	func testDownOptions() {
        let markdownString = "## [Down](https://github.com/iwasrobbed/Down)\n\n<strong>I'm strong!</strong>"
        let renderedHTML = "<strong>I'm strong!</strong>"

        // Set this view to initially be HTML safe
		let safeExpect = expectation(description: "DownView default init strips unsafe HTML")
        let toggleSafeExpect = expectation(description: "DownView update to unsafe does not strip unsafe HTML")
		var safeDownView: DownView?
		safeDownView = try? DownView(frame: .zero, markdownString: markdownString, didLoadSuccessfully: {
			self._pageContents(for: safeDownView!) { htmlString in
                XCTAssertTrue(safeDownView?.options == .default)
				XCTAssertFalse(htmlString!.contains(renderedHTML))
				safeExpect.fulfill()

                // Then change it to HTML unsafe options and ensure it's changed
                try? safeDownView?.update(markdownString: markdownString, options: .unsafe, didLoadSuccessfully: {
                    XCTAssertTrue(safeDownView?.options == .unsafe)
                    self._pageContents(for: safeDownView!) { htmlString in
                        XCTAssertTrue(htmlString!.contains(renderedHTML))
                        toggleSafeExpect.fulfill()
                    }
                })
			}
		})

        // Alternatively, init another view to be HTML unsafe
        let unsafeExpect = expectation(description: "DownView unsafe init does not strip unsafe HTML")
        let toggleUnsafeExpect = expectation(description: "DownView update to safe strips unsafe HTML")
        var unsafeDownView: DownView?
        unsafeDownView = try? DownView(frame: .zero, markdownString: markdownString, options: .unsafe, didLoadSuccessfully: {
            self._pageContents(for: unsafeDownView!) { htmlString in
                XCTAssertTrue(unsafeDownView?.options == .unsafe)
                XCTAssertTrue(htmlString!.contains(renderedHTML))
                unsafeExpect.fulfill()

                // And then toggle it to be HTML safe and ensure it's changed
                try? unsafeDownView?.update(markdownString: markdownString, options: .default, didLoadSuccessfully: {
                    XCTAssertTrue(unsafeDownView?.options == .default)
                    self._pageContents(for: unsafeDownView!) { htmlString in
                        XCTAssertFalse(htmlString!.contains(renderedHTML))
                        toggleUnsafeExpect.fulfill()
                    }
                })
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

private extension DownViewTests {
    
    func _pageContents(for downView: DownView, completion: @escaping (_ htmlString: String?) -> ()) {
        downView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html: Any?, _) in
            completion(html as? String)
        }
    }
    
}
#endif
