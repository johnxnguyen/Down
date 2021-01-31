//
//  CGRect_HelpersTests.swift
//  DownTests
//
//  Created by John Nguyen on 13.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
@testable import Down

class CGRect_HelpersTests: XCTestCase {

    func testRectInitializationWithBoundaries() {
        // When
        let result = CGRect(minX: 1, minY: 2, maxX: 3, maxY: 4)

        // Then
        XCTAssertEqual(CGRect(x: 1, y: 2, width: 2, height: 2), result)
    }

    func testRectTranslation() {
        // Given
        let sut = CGRect(x: 1, y: 2, width: 3, height: 4)

        // When
        let result = sut.translated(by: CGPoint(x: 5, y: 6))

        // Then
        XCTAssertEqual(CGRect(x: 6, y: 8, width: 3, height: 4), result)
    }
}
