//
//  StringTests.swift
//  Down
//
//  Created by Rob Phillips on 6/2/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import XCTest
@testable import Down

class StringTests: XCTestCase {

    func testStringToHTML() {
        // String is assumed to contain valid Markdown
        let string = "## [Down](https://github.com/iwasrobbed/Down)"
        let down = try? string.toHTML()
        XCTAssertNotNil(down)
        XCTAssertTrue(down == "<h2><a href=\"https://github.com/iwasrobbed/Down\">Down</a></h2>\n")
    }

}