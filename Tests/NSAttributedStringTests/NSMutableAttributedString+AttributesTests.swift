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

        // Check
        XCTAssertEqual(countAttribute(.foregroundColor, in: sut), 2)

        // When
        sut.replaceAttribute(.foregroundColor, value: UIColor.yellow)

        // Then
        let ranges = self.ranges(of: .foregroundColor, in: sut)
        XCTAssertEqual(ranges.count, 1)
        XCTAssertEqual(ranges.first, NSRange(location: 0, length: 12))
    }

}
