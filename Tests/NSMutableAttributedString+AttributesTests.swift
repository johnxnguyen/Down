//
//  NSMutableAttributedString+AttributesTests.swift
//  DownTests
//
//  Created by John Nguyen on 24.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import XCTest
@testable import Down

class NSMutableAttributedString_AttributesTests: XCTestCase {

    func countAttribute(_ name: NSAttributedString.Key, in str: NSAttributedString) -> Int {
        str.ranges(of: name).count
    }

    func ranges(of name: NSAttributedString.Key, in str: NSAttributedString) -> [NSRange] {
        var ranges = [NSRange]()
        str.enumerateAttribute(name, in: str.wholeRange, options: []) { _, range, _ in
            ranges.append(range)
        }

        return ranges
    }

    func testReplacingAttributes() {
        // Given
        let hello = NSAttributedString(string: "Hello ", attributes: [.foregroundColor: UIColor.black])
        let world = NSAttributedString(string: "world!", attributes: [.foregroundColor: UIColor.white])

        let sut = NSMutableAttributedString(attributedString: hello)
        sut.append(world)

        assertEquals(actual: countAttribute(.foregroundColor, in: sut), expected: 2)

        // When
        sut.replaceAttribute(.foregroundColor, value: UIColor.yellow)

        // Then
        let colorRanges = ranges(of: .foregroundColor, in: sut)
        assertEquals(actual: colorRanges.count, expected: 1)
        assertEquals(actual: colorRanges.first, expected: sut.wholeRange)
    }

}

func assertEquals<T: Equatable>(actual: T, expected: T) {
    XCTAssertEqual(actual, expected)
}
