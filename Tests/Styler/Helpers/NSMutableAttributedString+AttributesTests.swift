//
//  NSMutableAttributedString+AttributesTests.swift
//  DownTests
//
//  Created by John Nguyen on 24.06.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
@testable import Down

class NSMutableAttributedString_AttributesTests: XCTestCase {

    private let key1 = NSAttributedString.Key("dummyKey1")
    private let key2 = NSAttributedString.Key("dummyKey2")
    private let dummyValue = "dummyValue"

    func testSettingAttributes() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello", attributes: [key1: dummyValue])

        // Check
        XCTAssertEqual(sut.ranges(of: key1), [sut.wholeRange])

        // When
        sut.setAttributes([key2: dummyValue])

        // Then
        var attributeRanges = sut.ranges(of: key1)
        XCTAssertTrue(attributeRanges.isEmpty)

        attributeRanges = sut.ranges(of: key2)
        XCTAssertEqual(attributeRanges, [sut.wholeRange])
        XCTAssertTrue(value(for: key2, inRange: attributeRanges.first!, isEqualTo: dummyValue, sut: sut))
    }

    func testAddingAttributes() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello")

        // When
        sut.addAttributes([key1: dummyValue])

        // Then
        let attributeRanges = sut.ranges(of: key1)
        XCTAssertEqual(attributeRanges, [sut.wholeRange])
        XCTAssertTrue(value(for: key1, inRange: attributeRanges.first!, isEqualTo: dummyValue, sut: sut))
    }

    func testAddingAttribute() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello")

        // When
        sut.addAttribute(for: key1, value: dummyValue)

        // Then
        let attributeRanges = sut.ranges(of: key1)
        XCTAssertEqual(attributeRanges, [sut.wholeRange])
        XCTAssertTrue(value(for: key1, inRange: attributeRanges.first!, isEqualTo: dummyValue, sut: sut))
    }

    func testRemovingAttribute() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello", attributes: [key1: dummyValue])

        // When
        sut.removeAttribute(for: key1)

        // Then
        let attributeRanges = sut.ranges(of: key1)
        XCTAssertTrue(attributeRanges.isEmpty)
    }

    func testReplacingAttribute() {
        // Given
        let hello = NSAttributedString(string: "Hello ", attributes: [.foregroundColor: DownColor.black])
        let world = NSAttributedString(string: "world!", attributes: [.foregroundColor: DownColor.white])

        let sut = NSMutableAttributedString(attributedString: hello)
        sut.append(world)

        // Check
        XCTAssertEqual(countAttribute(.foregroundColor, in: sut), 2)

        // When
        sut.replaceAttribute(for: .foregroundColor, value: DownColor.yellow)

        // Then
        let attributeRanges = sut.ranges(of: .foregroundColor)
        XCTAssertEqual(attributeRanges.count, 1)
        XCTAssertEqual(attributeRanges.first, NSRange(location: 0, length: 12))
        XCTAssertTrue(value(for: .foregroundColor, inRange: attributeRanges.first!, isEqualTo: DownColor.yellow, sut: sut))
    }

    func testUpdatingAttribute() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello", attributes: [key1: dummyValue])

        // When
        sut.updateExistingAttributes(for: key1) { (value: String) in
            value.uppercased()
        }

        // Then
        let attributeRanges = sut.ranges(of: key1)
        XCTAssertEqual(attributeRanges, [sut.wholeRange])
        XCTAssertTrue(value(for: key1, inRange: attributeRanges.first!, isEqualTo: dummyValue.uppercased(), sut: sut))
    }

    func testUpdatingAttributeInRange() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello world", attributes: [key1: dummyValue])
        let rangeOfFirstWord = NSRange(location: 0, length: 6)
        let rangeOfSecondWord = NSRange(location: 6, length: 5)

        // When
        sut.updateExistingAttributes(for: key1, in: rangeOfFirstWord) { (value: String) in
            "some new value"
        }

        // Then
        let attributeRanges = sut.ranges(of: key1)
        XCTAssertEqual(attributeRanges.count, 2)
        XCTAssertEqual(attributeRanges, [rangeOfFirstWord, rangeOfSecondWord])
        XCTAssertTrue(value(for: key1, inRange: attributeRanges.first!, isEqualTo: "some new value", sut: sut))
    }

    func testUpdatingAttributeThatDidNotExistInRangeDoesNothing() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello world")
        let rangeOfFirstWord = NSRange(location: 0, length: 6)

        // When
        sut.updateExistingAttributes(for: key1, in: rangeOfFirstWord) { (value: String) in
            "some new value"
        }

        // Then
        let attributeRanges = sut.ranges(of: key1)
        XCTAssertTrue(attributeRanges.isEmpty)
    }

    func testAdddingAttributeInMissingRanges() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello world")
        let rangeOfFirstWord = NSRange(location: 0, length: 6)
        let rangeOfSecondWord = NSRange(location: 6, length: 5)

        sut.addAttribute(key1, value: dummyValue, range: rangeOfFirstWord)

        // When
        sut.addAttributeInMissingRanges(for: key1, value: "some new value")

        // Then
        let attributeRanges = sut.ranges(of: key1)
        XCTAssertEqual(attributeRanges.count, 2)
        XCTAssertEqual(attributeRanges, [rangeOfFirstWord, rangeOfSecondWord])
        XCTAssertTrue(value(for: key1, inRange: attributeRanges.first!, isEqualTo: dummyValue, sut: sut))
        XCTAssertTrue(value(for: key1, inRange: attributeRanges.last!, isEqualTo: "some new value", sut: sut))
    }

    func testAdddingAttributeInMissingRangesDoesNothingIfNoMissingRanges() {
        // Given
        let sut = NSMutableAttributedString(string: "Hello world", attributes: [key1: dummyValue])

        // When
        sut.addAttributeInMissingRanges(for: key1, value: "some new value")

        // Then
        let attributeRanges = sut.ranges(of: key1)
        XCTAssertEqual(attributeRanges.count, 1)
        XCTAssertEqual(attributeRanges.first!, sut.wholeRange)
        XCTAssertTrue(value(for: key1, inRange: attributeRanges.first!, isEqualTo: dummyValue, sut: sut))
    }
}

private extension NSMutableAttributedString_AttributesTests {

    func countAttribute(_ name: NSAttributedString.Key, in str: NSAttributedString) -> Int {
        str.ranges(of: name).count
    }

    func value<A: Equatable>(for name: NSAttributedString.Key, inRange: NSRange, isEqualTo aValue: A, sut: NSMutableAttributedString) -> Bool {
        var effectiveRange = NSRange()
        let value = sut.attribute(name, at: inRange.location, effectiveRange: &effectiveRange) as? A
        return value == aValue && effectiveRange == inRange
    }
}
