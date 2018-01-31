////
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation
import UIKit

extension Sequence where Iterator.Element == NSMutableAttributedString? {
    /// Returns the concatenation of the non nil elements in this sequence.
    func join() -> NSMutableAttributedString {
        return reduce(NSMutableAttributedString()) { acc, next -> NSMutableAttributedString in
            guard let unwrapped = next else { return acc }
            acc.append(unwrapped)
            return acc
        }
    }
}

// MARK: - SIMPLE

extension NSMutableAttributedString {
    
    var wholeRange: NSRange {
        return NSMakeRange(0, length)
    }
    
    func prependBreak() {
        prepend("\n")
    }
    func appendBreak() {
        append("\n")
    }
    
    private func prepend(_ string: String) {
        insert(NSAttributedString(string: string), at: 0)
    }
    
    private func append(_ string: String) {
        append(NSAttributedString(string: string))
    }
    
    func addAttributes(_ attrs: Style.Attributes?) {
        guard let attrs = attrs else { return }
        addAttributes(attrs, range: wholeRange)
    }
}

// MARK: - COMPLEX

extension NSMutableAttributedString {
    
    /// Updates the value for the given attribute key with the return value of
    // the given transform function.
    private func map<T>(overKey key: NSAttributedStringKey, using transform: (T) -> T) {
        // collect exists values & ranges for the key
        var values = [(value: T, range: NSRange)]()
        enumerateAttribute(key, in: wholeRange, options: []) { value, range, _ in
            guard let value = value as? T else { return }
            values.append((value, range))
        }
        // update the value with the transformation
        for (value, range) in values {
            addAttribute(key, value: transform(value), range: range)
        }
    }
    
    /// Italicizes the font while preserving existing symbolic traits.
    func italicize() {
        map(overKey: .font) { (font: UIFont) -> UIFont in
            return font.italic
        }
    }
    
    /// Boldens the font while preserving existing symbolic traits.
    func bolden() {
        map(overKey: .font) { (font: UIFont) -> UIFont in
            return font.bold
        }
    }
    
    /// Boldens the font while preserving existing symbolic traits and updates
    /// the font size.
    func bolden(with size: CGFloat) {
        map(overKey: .font) { (font: UIFont) -> UIFont in
            return font.withSize(size).bold
        }
    }
    
    // TODO: perhaps make this for any markdown attribute. But need to consider
    // that we're just checking for membership at the moment, not exact matches.
    var rangesOfNestedLists: [NSRange] {
        var result = [NSRange]()
        enumerateAttribute(.markdown, in: wholeRange, options: []) { val, range, _ in
            guard let markdown = val as? Markdown, markdown.contains(.list) else { return }
            result.append(range)
        }
        return result
    }
}
