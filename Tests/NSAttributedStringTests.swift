//
//  NSAttributedStringTests.swift
//  Down
//
//  Created by Rob Phillips on 6/2/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import XCTest
@testable import Down

class NSAttributedStringTests: XCTestCase {

    func testAttributedStringBindingsWork() {
        let attributedString = try? Down(markdownString: "## [Down](https://github.com/iwasrobbed/Down)").toAttributedString()
        XCTAssertNotNil(attributedString)
        XCTAssertTrue(attributedString!.string == "Down\n")
    }

    func testInstantiation() {
        let attributedString = try? NSAttributedString(htmlString: "<html><body><p>Oh Hai</p></body></html>")
        XCTAssertNotNil(attributedString)
        XCTAssertTrue(attributedString!.string == "Oh Hai\n")
    }

}