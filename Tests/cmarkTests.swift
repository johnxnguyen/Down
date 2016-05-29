//
//  cmarkTests.swift
//  cmarkTests
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import XCTest
@testable import Down

class cmarkTests: XCTestCase {

    func testBindingsWork() {
        let down = Down(markdownString: "## [Down](https://github.com/iwasrobbed/Down)")
        let html = try? down.toHTML()
        XCTAssertNotNil(html)
    }
    
}
