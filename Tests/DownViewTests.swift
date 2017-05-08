//
//  DownViewTests.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import XCTest
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
}

fileprivate extension DownViewTests {
    
    func _pageContents(for downView: DownView, completion: @escaping (_ htmlString: String?) -> ()) {
        downView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html: Any?, _) in
            completion(html as? String)
        }
    }
    
}
