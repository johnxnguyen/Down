//
//  NSAttributedStringHelpersTests.swift
//  DownTests
//
//  Created by John Nguyen on 24.06.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
@testable import Down

class NSAttributedString_HelpersTests: XCTestCase {

    let dummyKey = NSAttributedString.Key(rawValue: "key")
    let dummyValue = "value"

    func make(_ str: String, attributed: Bool = false) -> NSAttributedString {
        let attrs = attributed ? [dummyKey: dummyValue] : [:]
        return NSAttributedString(string: str, attributes: attrs)
    }

    // MARK: - Whole Ranges

    func testWholeRangeOfEmptyString() {
        // Given
        let sut = NSAttributedString()

        // When
        let result = sut.wholeRange

        // Then
        XCTAssertEqual(result, NSRange())
    }

    func testWholeRange() {
        // Given
        let sut = NSAttributedString(string: "Hello world!")

        // When
        let result = sut.wholeRange

        // Then
        XCTAssertEqual(result, NSRange(location: 0, length: 12))
    }

    // MARK: - Attribute Ranges

    func testRangesOfAttributeThatIsNonExistant() {
        // Given
        let sut = NSAttributedString(string: "Hello world!")

        // When
        let result = sut.ranges(of: dummyKey)

        // Then
        XCTAssertTrue(result.isEmpty)
    }

    func testRangesOfAttribute() {
        // Given
        let sut = NSMutableAttributedString()
        sut.append(make("Hello ", attributed: true))
        sut.append(make("world how do "))
        sut.append(make("you ", attributed: true))
        sut.append(make("do?"))

        // When
        let result = sut.ranges(of: dummyKey)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0], NSRange(location: 0, length: 6))  // "Hello "
        XCTAssertEqual(result[1], NSRange(location: 19, length: 4)) // "you "
    }

    func testRangesOfAttributeThatHasAdjacentValues() {
        // Given
        let sut = NSMutableAttributedString()
        sut.append(make("Hello ", attributed: true))
        sut.append(make("world ", attributed: true))
        sut.append(make("how do "))
        sut.append(make("you ", attributed: true))
        sut.append(make("do?"))

        // When
        let result = sut.ranges(of: dummyKey)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0], NSRange(location: 0, length: 12)) // "Hello world "
        XCTAssertEqual(result[1], NSRange(location: 19, length: 4)) // "you "
    }

  // MARK: - Missing Attribute Ranges


    func testRangesMissingAttribute_None() {
        // Given
        let sut = NSMutableAttributedString()
        sut.append(make("Hello world", attributed: true))

        // When
        let result = sut.rangesMissingAttribute(for: dummyKey)

        // Then
        XCTAssertTrue(result.isEmpty)
    }

    func testRangesMissingAttribute_Whole() {
        // Given
        let sut = NSMutableAttributedString()
        sut.append(make("Hello world", attributed: false))

        // When
        let result = sut.rangesMissingAttribute(for: dummyKey)

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0], NSRange(location: 0, length: 11)) // "Hello world"
    }

    func testRangesMissingAttribute_Partial() {
        // Given
        let sut = NSMutableAttributedString()
        sut.append(make("Hello "))
        sut.append(make("world ", attributed: true))
        sut.append(make("how do "))
        sut.append(make("you ", attributed: true))
        sut.append(make("do?"))

        // When
        let result = sut.rangesMissingAttribute(for: dummyKey)

        // Then
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], NSRange(location: 0, length: 6))  // "Hello "
        XCTAssertEqual(result[1], NSRange(location: 12, length: 7)) // "how do "
        XCTAssertEqual(result[2], NSRange(location: 23, length: 3)) // "do?"
    }

    // MARK: - Paragraph Ranges

    func testParagraphRangesOfEmptySring() {
        // Given
        let sut = NSAttributedString()

        // When
        let result = sut.paragraphRanges()

        // Then
        XCTAssertTrue(result.isEmpty)
    }

    func testParagraphRangesOfSingleWord() {
        // Given
        let sut = NSAttributedString(string: "Hello")

        // When
        let result = sut.paragraphRanges()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0], NSRange(location: 0, length: 5))
    }

    func testParagraphRanges() {
        // Given
        let sut = NSAttributedString(string:"Hello\nhello\nworld")

        // When
        let result = sut.paragraphRanges()

        // Then
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], NSRange(location: 0, length: 6))  // "Hello\n"
        XCTAssertEqual(result[1], NSRange(location: 6, length: 6))  // "hello\n"
        XCTAssertEqual(result[2], NSRange(location: 12, length: 5)) // "world"
    }

    func testParagraphRangesOfStringThatHasParagraphSeparators() {
        // Given
        let separator = "\u{2029}"
        let sut = NSAttributedString(string:"Hello\(separator)hello\(separator)world")

        // When
        let result = sut.paragraphRanges()

        // Then
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], NSRange(location: 0, length: 6))  // "Hello\u{2029}"
        XCTAssertEqual(result[1], NSRange(location: 6, length: 6))  // "hello\u{2029}"
        XCTAssertEqual(result[2], NSRange(location: 12, length: 5)) // "world"
    }

    func testParagraphRangesOfStringWithLargeBreaks() {
        // Given
        let sut = NSAttributedString(string:"Hello\n\nhello\n\n\nworld")

        // When
        let result = sut.paragraphRanges()

        // Then
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], NSRange(location: 0, length: 6))  // "Hello\n"
        XCTAssertEqual(result[1], NSRange(location: 7, length: 6))  // "hello\n"
        XCTAssertEqual(result[2], NSRange(location: 15, length: 5)) // "world
    }

  // MARK: - Enumeration

  func testEnumerationOfAttributes() {
    // Given
    let sut = NSMutableAttributedString()
    sut.append(make("Hello ", attributed: true))
    sut.append(make("world ", attributed: true))
    sut.append(make("how do "))
    sut.append(make("you ", attributed: true))
    sut.append(make("do?"))

    // When
    var result = [(String, NSRange)]()
    sut.enumerateAttributes(for: dummyKey) { (attr: String, range) in
      result.append((attr, range))
    }

    // Then
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result[0].0, "value")
    XCTAssertEqual(result[0].1, NSRange(location: 0, length: 12)) // "Hello world "
    XCTAssertEqual(result[1].0, "value")
    XCTAssertEqual(result[1].1, NSRange(location: 19, length: 4)) // "you "
  }
}
