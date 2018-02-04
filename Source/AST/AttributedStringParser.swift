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
    
    public init() {
        
    }
    
    public func parse(attributedString input: NSAttributedString) -> String {
        
        var result = ""
        var stack = [Markdown]()
        var seen: Markdown = .none
        
        let shouldOpen: (Markdown, Markdown) -> Bool = {
            $0.contains($1) && !seen.contains($1)
        }
        
        let shouldClose: (Markdown, Markdown) -> Bool = {
            !$0.contains($1) && seen.contains($1)
        }
        
        let open: (Markdown) -> Void = {
            seen.insert($0)
            stack.append($0)
            var syntax = ""
            switch $0 {
            case .header:   syntax = "# "
            case .code:     syntax = "`"
            case .bold:     syntax = "**"
            case .italic:   syntax = "_"
            default: break
                
            }
            result.append(syntax)
        }
        
        let close: (Markdown) -> Void = {
            seen.subtract($0)
            stack.removeLast()
            var syntax = ""
            switch $0 {
            case .header:   syntax = "\n"
            case .code:     syntax = "`"
            case .bold:     syntax = "**"
            case .italic:   syntax = "_"
            default: break
                
            }
            result.append(syntax)
        }
        
        // step through each char
        for idx in 0..<input.length {
            // determine the markdown
            let val = input.attribute(MarkdownIDAttributeName, at: idx, effectiveRange: nil)
            let markdown = (val as? Markdown) ?? .none
          
            // check for blocks first, then inlines
            
            // need to know when new markdown comes or leaves
            
            // new header
            if shouldOpen(markdown, .header) {
                open(.header)
            }
            // header is ended
            else if shouldClose(markdown, .header) {
                close(.header)
            }
            
        
            if shouldOpen(markdown, .bold) {
                // if there's code, and we've seen it already, close and open again
                let reopenCode =  markdown.contains(.code) && seen.contains(.code)
                if reopenCode { close(.code) }
                open(.bold)
                if reopenCode { open(.code) }
            }
            else if shouldClose(markdown, .bold) {
                close(.bold)
            }
            
            if shouldOpen(markdown, .italic) {
                // if there's code, and we've seen it already, close and open again
                let reopenCode =  markdown.contains(.code) && seen.contains(.code)
                if reopenCode { close(.code) }
                open(.italic)
                if reopenCode { open(.code) }
            }
            else if shouldClose(markdown, .italic) {
                close(.italic)
            }

            // check code after other inlines
            // problem if we start with code, then add bold/italic after
            if shouldOpen(markdown, .code) {
                open(.code)
            }
            else if shouldClose(markdown, .code) {
                close(.code)
            }
            
            result.append(input.attributedSubstring(from: NSMakeRange(idx, 1)).string)
         }
        
        // if seen is not empty, need to close it!
        while !stack.isEmpty { close(stack.last!) }
        
        return result
    }
}
