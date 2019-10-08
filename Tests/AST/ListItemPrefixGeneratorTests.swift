//
//  ListItemPrefixGeneratorTests.swift
//  DownTests
//
//  Created by John Nguyen on 13.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
@testable import Down

class ListItemPrefixGeneratorTests: XCTestCase {

    func testNumberPrefixGeneration() {
        // Given
        let sut = ListItemPrefixGenerator(listType: .ordered(start: 3), numberOfItems: 3)

        // Then
        XCTAssertEqual("3.", sut.next())
        XCTAssertEqual("4.", sut.next())
        XCTAssertEqual("5.", sut.next())
        XCTAssertNil(sut.next())
    }

    func testBulletPrefixGeneration() {
        // Given
        let sut = ListItemPrefixGenerator(listType: .bullet, numberOfItems: 3)

        // Then
        XCTAssertEqual("•", sut.next())
        XCTAssertEqual("•", sut.next())
        XCTAssertEqual("•", sut.next())
        XCTAssertNil(sut.next())
    }
}
