//
//  CGPoint_TranslateTests.swift
//  DownTests
//
//  Created by John Nguyen on 13.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
@testable import Down

class CGPoint_TranslateTests: XCTestCase {

    func testPointTranslation() {
        // Given
        let sut = CGPoint(x: 1, y: 2)

        // When
        let result = sut.translated(by: CGPoint(x: 3, y: 4))

        // Then
        XCTAssertEqual(CGPoint(x: 4, y: 6), result)
    }
}
