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
        return lhs.markdown.rawValue < rhs.markdown.rawValue
    }
    
    static func ==(lhs: MarkdownRange, rhs: MarkdownRange) -> Bool {
        return NSEqualRanges(lhs.range, rhs.range) && lhs.markdown == rhs.markdown
    }
}

public class AttributedStringParser {
    
    var stack = [Markdown]()
    var seen: Markdown = .none

    public init() {}
    
    public func parse(attributedString input: NSAttributedString) -> String {
        
        // fill stream with ranges for each atomic markdown
        var stream = [MarkdownRange]()
        for markdown in Markdown.atomicValues + [.none] {
            stream += ranges(of: markdown, in: input).map {
                MarkdownRange(markdown: markdown, range: $0)
            }
        }
        
        // sorting is very important. See the MarkdownRange struct
        // definition for how they are compared
        stream.sort()
        print("ranges: \(stream)")
        
        var result = ""
        var stack = [MarkdownRange]()
        var cursor = 0
        
        // note, not safe, must use with caution
        let pushHead: () -> Void = {
            let head = stream.remove(at: 0)
            // push to stack
            stack.append(head)
            // append suffix
            result.append(self.prefix(for: head.markdown))
            // update cursor
            cursor = head.range.location
        }
        
        // note, not safe, must use with caution
        let pop: () -> Void = {
            let top = stack.removeLast()
            // range from cursor to end of top range
            let range = NSRange(from: cursor, to: top.range.upperBound)
            // append substring
            result.append(input.attributedSubstring(from: range).string)
            // update cursor
            cursor = range.upperBound
            // append suffix
            result.append(self.suffix(for: top.markdown))
        }
        
        while true {
            if stream.isEmpty { break }
            if stack.isEmpty { pushHead() }
            let stackTop = stack.last!
            
            // look at next head
            if let head = stream.first {
                if stackTop.range.contains(head.range) {
                    // head is a subrange of stackTop
                    // take up to head location
                    let range = NSRange(from: cursor, to: head.range.location)
                    let str = input.attributedSubstring(from: range).string
                    result.append(str)
                    
                    pushHead()
                    continue
                }
                else if stackTop.range.overlaps(with: head.range) {
                    // head starts inside stackTop but extends outside
                    // split head range at the boundary
                    let boundary = stackTop.range.upperBound
                    let temp = stream.remove(at: 0)
                    let left = NSRange(from: temp.range.location, to: boundary)
                    let right = NSRange(from: boundary, to: temp.range.upperBound)
                    // both back into the array starting with right side
                    stream.insert(MarkdownRange(markdown: temp.markdown, range: right), at: 0)
                    stream.insert(MarkdownRange(markdown: temp.markdown, range: left), at: 0)
                    continue
                }
                else {
                    // head is disjoint with stackTop
                    pop()
                    continue
                }
            }
        }
        
        // flush stack
        while !stack.isEmpty { pop() }
        print("stack: \(stack)")
        print(result)
        return result
    }
    
    /// Returns a dictionary containing the subranges for each markdown type
    /// where this markdown is present in the given range.
    ///
    private func ranges(of markdown: Markdown, in attrStr: NSAttributedString) -> [NSRange] {
        
        var result = [NSRange]()
        let wholeRange = NSMakeRange(0, attrStr.length)
        
        attrStr.enumerateAttribute(MarkdownIDAttributeName, in: wholeRange, options: []) { val, range, _ in
            let currentMarkdown = (val as? Markdown) ?? .none
            
            // special case, b/c all markdown contains .none
            if markdown == .none {
                if currentMarkdown == .none {
                    result.append(range)
                }
            }
            else if currentMarkdown.contains(markdown) {
                result.append(range)
            }
        }
        
        // since we reset typing attributes at each change, the length of the ranges
        // corresponds to the length of the last edit. This results in numerous
        // ranges that are adjacent to each other. We want to combine these together.
        return result.unified
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
        case .h1, .h2, .h3:     return "\n"
        case .code:             return "`"
        case .bold:             return "**"
        case .italic:           return "_"
        default:                return ""
        }
    }
}

fileprivate extension NSRange {
    
    /// Returns true iff the given range is entirely contained within self.
    ///
    func contains(_ range: NSRange) -> Bool {
        guard let intersection = self.intersection(range) else { return false }
        return NSEqualRanges(intersection, range)
    }
    
    // TODO: Test this, check case that self is before other
    func overlaps(with range: NSRange) -> Bool {
        // there is a non empty intersection
        guard let intersection = self.intersection(range) else { return false }
        guard intersection.length > 0 else { return false }
        // the intersection is not equal to either range
        guard !NSEqualRanges(self, intersection) else { return false }
        guard !NSEqualRanges(range, intersection) else { return false }
        return true
    }
    
    init(from x: Int, to y: Int) {
        self = NSMakeRange(x, y - x)
    }
}

private extension Sequence where Iterator.Element == NSRange  {
    
    /// Returns a copy of the array where adjacent ranges (ones that have no
    /// gaps between them) are unified. Eg. [{0,1},{1,2},{4,1}] -> [{0,3},{4,1}]
    ///
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

private extension Array where Iterator.Element == (Markdown, NSRange)  {
    /// Removes and returns all elements that meet the given condition.
    mutating func removeAll(where condition: ((Markdown, NSRange) -> Bool)) -> [(Markdown, NSRange)] {
        var result = [(Markdown, NSRange)]()
        var indicesToRemove = [Int]()
        
        for (idx, element) in enumerated() {
            if condition(element.0, element.1) {
                indicesToRemove.append(idx)
                result.append(element)
            }
        }
        
        for idx in indicesToRemove.reversed() {
            result.append(self.remove(at: idx))
        }
        
        return result
    }
}
