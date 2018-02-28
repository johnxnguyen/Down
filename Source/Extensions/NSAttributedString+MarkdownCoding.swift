//
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

extension NSAttributedString {
    
    // CoreData cannot store NSAttributedString with attributes of type `Markdown`
    // (a struct conforming to `OptionSet`), so we need to convert these to their
    // raw values (of type Int) before saving to CoreData. When we retrieve
    // from the store, we also need to convert them back to their original `Markdown`
    // types.
    
    public var withEncodedMarkdownIDs: NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        copy.map(overKey: MarkdownIDAttributeName) { (markdown: Markdown) -> Int in
            return markdown.rawValue
        }
        return copy
    }
    
    public var withDecodedMarkdownIDs: NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        copy.map(overKey: MarkdownIDAttributeName) { (rawValue: Int) -> Markdown in
            return Markdown(rawValue: rawValue)
        }
        return copy
    }
}
