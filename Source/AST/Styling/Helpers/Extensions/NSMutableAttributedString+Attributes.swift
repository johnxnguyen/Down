//
//  NSMutableAttributedString+Attributes.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {

    func setAttributes(_ attrs: Attributes) {
        setAttributes(attrs, range: wholeRange)
    }

    func addAttributes(_ attrs: Attributes) {
        addAttributes(attrs, range: wholeRange)
    }

    func addAttribute(for key: Key, value: Any) {
        addAttribute(key, value: value, range: wholeRange)
    }

    func removeAttribute(for key: Key) {
        removeAttribute(key, range: wholeRange)
    }

    func replaceAttribute(for key: Key, value: Any) {
        replaceAttribute(for: key, value: value, inRange: wholeRange)
    }

    func replaceAttribute(for key: Key, value: Any, inRange range: NSRange) {
        removeAttribute(key, range: range)
        addAttribute(key, value: value, range: range)
    }

    func updateExistingAttributes<A>(for key: Key, using f: (A) -> A) {
        updateExistingAttributes(for: key, in: wholeRange, using: f)
    }

    func updateExistingAttributes<A>(for key: Key, in range: NSRange, using f: (A) -> A) {
        var exisitngValues = [(value: A, range: NSRange)]()
        enumerateAttributes(for: key, in: range) { exisitngValues.append(($0, $1)) }
        exisitngValues.forEach { addAttribute(key, value: f($0.0), range: $0.1) }
    }

    func addAttributeInMissingRanges<A>(for key: Key, value: A) {
        addAttributeInMissingRanges(for: key, value: value, within: wholeRange)
    }

    func addAttributeInMissingRanges<A>(for key: Key, value: A, within range: NSRange) {
        rangesMissingAttribute(for: key, in: range).forEach {
            addAttribute(key, value: value, range: $0)
        }
    }
}
