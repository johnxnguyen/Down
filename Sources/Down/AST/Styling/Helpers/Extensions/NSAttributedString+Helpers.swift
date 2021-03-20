//
//  NSAttributedString+Helpers.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation

extension NSAttributedString {

    typealias Attributes = [NSAttributedString.Key: Any]

    // MARK: - Ranges

    var wholeRange: NSRange {
        return NSRange(location: 0, length: length)
    }

    func ranges(of key: Key) -> [NSRange] {
        return ranges(of: key, in: wholeRange)
    }

    func ranges(of key: Key, in range: NSRange) -> [NSRange] {
        return ranges(for: key, in: range, where: { $0 != nil })
    }

    func rangesMissingAttribute(for key: Key) -> [NSRange] {
        return rangesMissingAttribute(for: key, in: wholeRange)
    }

    func rangesMissingAttribute(for key: Key, in range: NSRange) -> [NSRange] {
        return ranges(for: key, in: range, where: { $0 == nil })
    }

    private func ranges(for key: Key, in range: NSRange, where predicate: (Any?) -> Bool) -> [NSRange] {
        var ranges = [NSRange]()

        enumerateAttribute(key, in: range, options: []) { value, attrRange, _ in
            if predicate(value) {
                ranges.append(attrRange)
            }
        }

        return ranges
    }

    func paragraphRanges() -> [NSRange] {
        guard length > 0 else { return [] }

        func nextParagraphRange(at location: Int) -> NSRange {
            return NSString(string: string).paragraphRange(for: NSRange(location: location, length: 1))
        }

        var result = [nextParagraphRange(at: 0)]

        while let currentLocation = result.last?.upperBound, currentLocation < length {
            result.append(nextParagraphRange(at: currentLocation))
        }

        return result.filter { $0.length > 1 }
    }

    // MARK: - Enumerate attributes

    func enumerateAttributes<A>(for key: Key, block: (_ attr: A, _ range: NSRange) -> Void) {
        enumerateAttributes(for: key, in: wholeRange, block: block)
    }

    func enumerateAttributes<A>(for key: Key, in range: NSRange, block: (_ attr: A, _ range: NSRange) -> Void) {
        enumerateAttribute(key, in: range, options: []) { value, range, _ in
            if let value = value as? A {
                block(value, range)
            }
        }
    }

}
