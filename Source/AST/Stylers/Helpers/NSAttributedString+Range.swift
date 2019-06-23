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
}
