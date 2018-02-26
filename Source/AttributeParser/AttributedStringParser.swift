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

public class AttributedStringParser {
    
    // MARK: - Public Interface
    
    public init() {}
    
    /// Converts an attributed string containing markdown attributes into a
    /// plain text string containing markdown syntax.
    public func parse(attributedString attrStr: NSAttributedString) -> String {
        
        let input = prepare(input: attrStr)
        
        // fill stream with ranges for each atomic markdown
        var stream = [MarkdownRange]()
        for markdown in Markdown.atomicValues + [.none] {
            stream += input.ranges(containing: markdown).map {
                MarkdownRange(markdown: markdown, range: $0)
            }
        }
        
        // sorting is very important. See the MarkdownRange definition for
        // how the elements are compared
        stream.sort()
        
        // the output
        var result = ""
        // keeps track of the position in the input string
        var cursor = 0
        // keeps track of markdown nesting
        var stack = [MarkdownRange]()
        
        // not safe, use with caution
        let pushNext: () -> Void = {
            let next = stream.remove(at: 0)
            // push to stack
            stack.append(next)
            // append suffix
            result.append(self.prefix(for: next.markdown))
            // update cursor
            cursor = next.range.location
        }
        
        // not safe, use with caution
        let pop: () -> Void = {
            let top = stack.removeLast()
            // range from cursor to end of top's range
            let range = NSRange(from: cursor, to: top.range.upperBound)
            // append substring
            result.append(input.attributedSubstring(from: range).string)
            // append suffix
            result.append(self.suffix(for: top.markdown))
            // update cursor
            cursor = range.upperBound
        }
        
        // begin parsing
        while true {
            if stream.isEmpty { break }
            if stack.isEmpty { pushNext() }
            let current = stack.last!
            
            if let next = stream.first {
                if current.range.contains(next.range) {
                    // next is nested in current
                    // take input until next's location
                    let range = NSRange(from: cursor, to: next.range.location)
                    let str = input.attributedSubstring(from: range).string
                    result.append(str)
                    // enter the nest
                    pushNext()
                    continue
                }
                else if current.range.overlaps(with: next.range) {
                    // next begins in current, but ends outside of it
                    // split next's range at the boundary
                    let boundary = current.range.upperBound
                    let temp = stream.remove(at: 0)
                    let left = NSRange(from: temp.range.location, to: boundary)
                    let right = NSRange(from: boundary, to: temp.range.upperBound)
                    
                    // it's possible that after spliting, the right side begins
                    // with whitespace. This is a problem if the right side
                    // is inline markdown, because these can't begin with
                    // whitespace. If necessary, we need to split the right side
                    // again where the whitespace ends. The range of whitespace
                    // will be assigned .none markdown.
                    
                    let str = input.attributedSubstring(from: right).string
                    let wsLength = lengthOfWhitespacePrefix(of: str)
                    
                    if wsLength > 0 {
                        // split the right side
                        let whitespaceRange = NSMakeRange(right.location, wsLength)
                        let newRight = NSMakeRange(right.location + wsLength, right.length - wsLength)
                        stream.insert(MarkdownRange(markdown: temp.markdown, range: newRight), at: 0)
                        stream.insert(MarkdownRange(markdown: .none, range: whitespaceRange), at: 0)
                    }
                    else {
                        stream.insert(MarkdownRange(markdown: temp.markdown, range: right), at: 0)
                    }
                    
                    stream.insert(MarkdownRange(markdown: temp.markdown, range: left), at: 0)
                    continue
                }
                else {
                    // next is disjoint with current
                    // finish up with current before continuing with next
                    pop()
                    continue
                }
            }
        }
        
        // flush stack
        while !stack.isEmpty { pop() }
        return result
    }
    
    // MARK: - Private Interface
    
    /// Used as an element in the parsing stream to represent the range
    /// of an attributed string where an atomic markdown ID is present.
    private struct MarkdownRange: Comparable, CustomStringConvertible {
        
        let markdown: Markdown
        let range: NSRange
        
        var description: String {
            return "\(markdown): \(range)"
        }
        
        static func <(lhs: MarkdownRange, rhs: MarkdownRange) -> Bool {
            // first compare range location ascending
            if lhs.range.location < rhs.range.location { return true }
            if lhs.range.location > rhs.range.location { return false }
            // then compare range length descending
            if lhs.range.length > rhs.range.length     { return true }
            if lhs.range.length < rhs.range.length     { return false }
            // finally compare markdown priority ascending
            return lhs.markdown.priority < rhs.markdown.priority
        }
        
        static func ==(lhs: MarkdownRange, rhs: MarkdownRange) -> Bool {
            return NSEqualRanges(lhs.range, rhs.range) && lhs.markdown == rhs.markdown
        }
    }
    
    /// Scans the bold, italic and code attributes of the given input and removes
    /// the corresponding markdown ID from any any whitespace prefixes or suffixes.
    /// This is important b/c bold, italic and code require the syntax to not
    /// preceed or succeed whitespace.
    private func prepare(input: NSAttributedString) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(attributedString: input)
        
        // first check that there is a newline after every header, insert
        // one if needed
        for header in [Markdown.h1, .h2, .h3] {
            var locationsToInsertNewlines = [Int]()
            for range in attrStr.ranges(containing: header) {
                // check the last char of header possibly the char after
                let len = range.upperBound == attrStr.length ? 1 : 2
                let chars = attrStr.attributedSubstring(from: NSMakeRange(range.upperBound - 1, len)).string
                // if neither are newline
                if !(chars.contains("\n") || chars.contains("\r")) {
                    locationsToInsertNewlines.append(range.upperBound)
                }
            }
            
            // insert newlines in reverse order to maintain string location integrity
            locationsToInsertNewlines.sorted(by: >).forEach {
                attrStr.insert(NSAttributedString(string: "\n"), at: $0)
            }
        }
        
        
        for markdown in [Markdown.bold, .italic, .code] {
            
            let removeMarkdown: (Markdown) -> (Markdown) = {
                return $0.subtracting(markdown)
            }
            
            // for each range where this markdown is present
            for range in attrStr.ranges(containing: markdown) {
                // inspect the string at this range
                let str = attrStr.attributedSubstring(from: range).string
                // remove this markdown ID from whitespace prefix
                let prefixLen = lengthOfWhitespacePrefix(of: str)
                let prefixRange = NSMakeRange(range.location, prefixLen)
                attrStr.map(overKey: MarkdownIDAttributeName, inRange: prefixRange, using: removeMarkdown)
                // remove this markdown ID from whitespace suffix
                let suffixLen = lengthOfWhitespaceSuffix(of: str)
                let suffixRange = NSMakeRange(range.upperBound - suffixLen, suffixLen)
                attrStr.map(overKey: MarkdownIDAttributeName, inRange: suffixRange, using: removeMarkdown)
    
                // finally, remove this markdown ID from any newlines
                let regex = try! NSRegularExpression(pattern: "[\\n\\r]", options: [])
                regex.enumerateMatches(in: attrStr.string, options: [], range: range) { match, _, _ in
                    if let range = match?.range, range.location != NSNotFound {
                        attrStr.map(overKey: MarkdownIDAttributeName, inRange: range, using: removeMarkdown)
                    }
                }
            }
        }
            
        return attrStr
    }
    
    /// Returns the length of leading whitespace for the given string. This
    /// will be 0 if there is none, or the length of the string if the string
    /// contains only whitespace.
    private func lengthOfWhitespacePrefix(of str: String) -> Int {
        let set = CharacterSet.whitespaces.inverted
        if let loc = str.rangeOfCharacter(from: set)?.lowerBound {
            return str.distance(from: str.startIndex, to: loc)
        }
        return str.distance(from: str.startIndex, to: str.endIndex)
    }
    
    /// Returns the length of trailing whitespace for the given string. This
    /// will be 0 if there is none, or the length of the string if the string
    /// contains only whitespace.
    private func lengthOfWhitespaceSuffix(of str: String) -> Int {
        let set = CharacterSet.whitespaces.inverted
        if let loc = str.rangeOfCharacter(from: set, options: .backwards, range: nil)?.upperBound {
            return str.distance(from: loc, to: str.endIndex)
        }
        return str.distance(from: str.startIndex, to: str.endIndex)
    }
    
    /// Returns the syntax prefix for the given markdown. Note, this will
    /// return prefixes for atomic markdown values only.
    private func prefix(for markdown: Markdown) -> String {
        switch markdown {
        case .h1:       return "# "
        case .h2:       return "## "
        case .h3:       return "### "
        case .code:     return "`"
        case .bold:     return "**"
        case .italic:   return "_"
        default:        return ""
        }
    }
    
    /// Returns the syntax suffix for the given markdown. Note, this will
    /// return suffixes for atomic markdown values only.
    private func suffix(for markdown: Markdown) -> String {
        switch markdown {
        case .h1, .h2, .h3:     return ""   // trailing newline is already ensured in string preparation
        case .code:             return "`"
        case .bold:             return "**"
        case .italic:           return "_"
        default:                return ""
        }
    }
}

// MARK: - Helpers

private extension NSRange {
    
    /// Range between two locations
    init(from x: Int, to y: Int) {
        self = NSMakeRange(x, y - x)
    }

    /// Returns true iff the given range is a subrange of the receiver.
    func contains(_ range: NSRange) -> Bool {
        guard let intersection = self.intersection(range) else { return false }
        return NSEqualRanges(intersection, range)
    }
    
    /// Returns true iff the given range is a partial subrange of the receiver.
    func overlaps(with range: NSRange) -> Bool {
        // there is a non empty intersection
        guard let intersection = self.intersection(range), intersection.length > 0
        else { return false }
        // the intersection is not equal to either range
        return !NSEqualRanges(self, intersection) && !NSEqualRanges(range, intersection)
    }
}

extension Sequence where Iterator.Element == NSRange  {
    /// Returns a copy of the array where ranges that could be expressed a
    /// single range are replaced. Eg. {0,1},{1,1},{3,1} -> {0,2},{3,1}
    var unified: [NSRange] {
        let sorted = self.sorted { return $0.location <= $1.location }
        
        return sorted.reduce(into: [], { (acc: inout [NSRange], nextRange) in
            if acc.isEmpty {
                return acc.append(nextRange)
            } else {
                let last = acc.popLast()!
                // if adjacent
                if NSMaxRange(last) >= nextRange.lowerBound {
                    return acc.append(NSUnionRange(last, nextRange))
                } else {
                    return acc.append(contentsOf: [last, nextRange])
                }
            }
        })
    }
}
