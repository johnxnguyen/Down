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
        let downView = try? DownView(frame: .zero, markdownString: "## [Down](https://github.com/iwasrobbed/Down)")
        XCTAssertNotNil(downView)
    }

}
