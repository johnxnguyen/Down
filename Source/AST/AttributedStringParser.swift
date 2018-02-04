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
    
    var stack = [Markdown]()
    var seen: Markdown = .none

    public init() {}
    
    public func parse(attributedString input: NSAttributedString) -> String {
        
        var result = ""
        stack.removeAll()
        seen = .none
        
        let appendPrefix: (Markdown) -> Void = {
            self.seen.insert($0)
            self.stack.append($0)
            result.append(self.prefix(for: $0))
        }
        
        let appendSuffix: (Markdown) -> Void = {
            self.seen.subtract($0)
            self.stack.removeLast()
            result.append(self.suffix(for: $0))
        }
        
        // iterate through the characters
        for idx in 0..<input.length {
            // get the markdown at the current index
            let val = input.attribute(MarkdownIDAttributeName, at: idx, effectiveRange: nil)
            let markdown = (val as? Markdown) ?? .none
            
            // the order in which we check the markdown is important. We should
            // start with on the highest level (markdown that can't be nested)
            // and end on the deeplest level (markdown that can't contain nested
            // markdown).
            
            Markdown.atomicValues.forEach {
                if shouldInsertPrefix(for: $0, given: markdown) {
                    appendPrefix($0)
                }
                else if shouldInsertSuffix(for: $0, given: markdown) {
                    appendSuffix($0)
                }
            }
            
//            if shouldInsertPrefix(for: .header, given: markdown) {
//                appendPrefix(.header)
//            }
//            else if shouldInsertSuffix(for: .header, given: markdown) {
//                appendSuffix(.header)
//            }
//
//            if shouldInsertPrefix(for: .bold, given: markdown) {
//                appendPrefix(.bold)
//            }
//            else if shouldInsertSuffix(for: .bold, given: markdown) {
//                appendSuffix(.bold)
//            }
//
//            if shouldInsertPrefix(for: .italic, given: markdown) {
//                appendPrefix(.italic)
//            }
//            else if shouldInsertSuffix(for: .italic, given: markdown) {
//                appendSuffix(.italic)
//            }
//
//            if shouldInsertPrefix(for: .code, given: markdown) {
//                appendPrefix(.code)
//            }
//            else if shouldInsertSuffix(for: .code, given: markdown) {
//                appendSuffix(.code)
//            }
            
            result.append(input.attributedSubstring(from: NSMakeRange(idx, 1)).string)
         }
        
        // close all remaining markdown
        while !stack.isEmpty { appendSuffix(stack.last!) }
        return result
    }
    
    /// Determines whether the prefix for the atomic markdown value should be inserted
    /// depending on the currentMarkdown.
    private func shouldInsertPrefix(for markdown: Markdown, given currentMarkdown: Markdown) -> Bool {
        // we insert prefix for markdown that has not yet been seen and is now
        // present in currentMarkdown
        return !seen.contains(markdown) && currentMarkdown.contains(markdown)
    }
    
    /// Determines whether the suffix for the atomic markdown value should be inserted
    /// depending on the currentMarkdown.
    private func shouldInsertSuffix(for markdown: Markdown, given currentMarkdown: Markdown) -> Bool {
        // we insert suffix for markdown only when it has been seen and is now
        // no longer present in currentMarkdown
        return seen.contains(markdown) && !currentMarkdown.contains(markdown)
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
