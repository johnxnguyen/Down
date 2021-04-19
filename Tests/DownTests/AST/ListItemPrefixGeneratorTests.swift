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

    func testNumberStaticPrefixGeneration() {
        // Given
        let sut = StaticListItemPrefixGenerator(listType: .ordered(start: 3), numberOfItems: 3, nestDepth: 1)

        // Then
        XCTAssertEqual("3.", sut.next())
        XCTAssertEqual("4.", sut.next())
        XCTAssertEqual("5.", sut.next())
        XCTAssertNil(sut.next())
    }

    func testBulletStaticPrefixGeneration() {
        // Given
        let sut = StaticListItemPrefixGenerator(listType: .bullet, numberOfItems: 3, nestDepth: 1)

        // Then
        XCTAssertEqual("•", sut.next())
        XCTAssertEqual("•", sut.next())
        XCTAssertEqual("•", sut.next())
        XCTAssertNil(sut.next())
    }

}
