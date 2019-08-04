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

    // TODO: you can just write Key
    func addAttribute(_ name: NSAttributedString.Key, value: Any) {
        addAttribute(name, value: value, range: wholeRange)
    }

    func removeAttribute(_ name: NSAttributedString.Key) {
        removeAttribute(name, range: wholeRange)
    }

    func replaceAttribute(_ name: NSAttributedString.Key, value: Any) {
        replaceAttribute(name, value: value, inRange: wholeRange)
    }

    func replaceAttribute(_ name: NSAttributedString.Key, value: Any, inRange range: NSRange) {
        removeAttribute(name, range: range)
        addAttribute(name, value: value, range: range)
    }

    // TODO: rename to "updateExistingAtribute"
    // TODO: test the default value
    func updateAttribute<A>(_ key: NSAttributedString.Key, with f: (A) -> A) {
        updateAttribute(key, inRange: wholeRange, with: f)
    }

    // TODO: This default value makes the method do more than one thing...
    func updateAttribute<A>(_ key: NSAttributedString.Key, inRange range: NSRange, with f: (A) -> A) {
        var exisitngValues = [(value: A, range: NSRange)]()
        enumerate(key: key, inRange: range) { exisitngValues.append(($0, $1)) }
        exisitngValues.forEach { addAttribute(key, value: f($0.0), range: $0.1) }
    }

    // TODO: test
    func addAttributeInMissingRanges<A>(key: Key, value: A) {
        addAttributeInMissingRanges(key: key, value: value, withinRange: wholeRange)
    }

    // TODO: test
    func addAttributeInMissingRanges<A>(key: Key, value: A, withinRange range: NSRange) {
        rangesMissingAttribute(name: key, inRange: range).forEach {
            addAttribute(key, value: value, range: $0)
        }
    }

    // TODO: move this to attributed string extension
    func enumerate<A>(key: NSAttributedString.Key, block: (_ attr: A, _ range: NSRange) -> Void) {
        enumerate(key: key, inRange: wholeRange, block: block)
    }

    func enumerate<A>(key: NSAttributedString.Key, inRange range: NSRange, block: (_ attr: A, _ range: NSRange) -> Void) {
        enumerateAttribute(key, in: range, options: []) { value, range, _ in
            if let value = value as? A {
                block(value, range)
            }
        }
    }
}
