//
//  NSAttributedString+Range.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

extension NSAttributedString {

    typealias Attributes = [NSAttributedString.Key: Any]

    var wholeRange: NSRange {
        return NSRange(location: 0, length: length)
    }

    func ranges(of name: NSAttributedString.Key) -> [NSRange] {
        var ranges = [NSRange]()
        enumerateAttribute(name, in: wholeRange, options: []) { _, range, _ in
            ranges.append(range)
        }

        return ranges
    }

    func paragraphRanges() -> [NSRange] {
        guard length > 0 else { return [] }

        var result = [NSRange]()

        func nextParagraphRange(at location: Int) -> NSRange {
            return NSString(string: string).paragraphRange(for: NSRange(location: location, length: 1))
        }

        result.append(nextParagraphRange(at: 0))


        while let currentLocation = result.last?.upperBound, currentLocation < length {
            result.append(nextParagraphRange(at: currentLocation))
        }

        return result.filter { $0.length > 1 }
    }
}
