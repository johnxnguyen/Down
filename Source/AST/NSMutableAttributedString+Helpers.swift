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

extension Sequence where Iterator.Element == NSMutableAttributedString {
    /// Returns the concatenation of the elements in this sequence.
    func join() -> NSMutableAttributedString {
        return reduce(NSMutableAttributedString()) { acc, next -> NSMutableAttributedString in
            acc.append(next)
            return acc
        }
    }
}


extension NSMutableAttributedString {
    /// The range spanning the entire string.
    var wholeRange: NSRange {
        return NSMakeRange(0, length)
    }
    
    func prependBreak() { prepend("\n") }
    func appendBreak()  { append("\n")  }
    //    func appendSpace()  { append(" ")   }
    //    func prependSpace() { prepend(" ")  }
    
    private func prepend(_ string: String) {
        insert(NSAttributedString(string: string), at: 0)
    }
    
    private func append(_ string: String) {
        append(NSAttributedString(string: string))
    }
}

