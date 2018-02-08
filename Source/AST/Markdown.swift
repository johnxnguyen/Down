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

/// The key for Markdown identification in an NSAttributedString
public let MarkdownIDAttributeName = "MarkdownIDAttributeName"

/// Use as values for `MarkdownIDAttributeName` to be able to easily
/// identify ranges of markdown in an `NSAttributedString`.
public struct Markdown: OptionSet, Hashable, CustomStringConvertible {
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
        self.hashValue = rawValue.hashValue
    }
    
    public let rawValue: Int
    public var hashValue: Int
    
    public static let none     = Markdown(rawValue: 0)
    public static let h1       = Markdown(rawValue: 1 << 0)
    public static let h2       = Markdown(rawValue: 1 << 1)
    public static let h3       = Markdown(rawValue: 1 << 2)
    public static let bold     = Markdown(rawValue: 1 << 3)
    public static let italic   = Markdown(rawValue: 1 << 4)
    public static let code     = Markdown(rawValue: 1 << 5)
    public static let list     = Markdown(rawValue: 1 << 6)
    public static let quote    = Markdown(rawValue: 1 << 7)
    public static let link     = Markdown(rawValue: 1 << 8)
    
    public static var atomicValues: Array<Markdown> = [
        .h1, .h2, .h3, .bold, .italic, .code, .list, .quote, .link
    ]
    
    public var isHeader: Bool {
        return self != .none && [.h1, .h2, .h3].contains(self)
    }
    
    public var containsHeader: Bool {
        return self.contains(.h1) || self.contains(.h2) || self.contains(.h3)
    }
    
    public var headerValue: Markdown? {
        if      self.contains(.h1) { return .h1 }
        else if self.contains(.h2) { return .h2 }
        else if self.contains(.h3) { return .h3 }
        return nil
    }
    
    /// Used when parsing attributed strings to determine which atomic markdown
    /// should be processed first. For example, if "hello" contains both
    /// h1 and italic, then the parser should return `# *hello*` instead of
    /// `*# hello*`.
    var priority: Int {
        switch self {
        case .quote:            return 0
        case .h1, .h2, .h3:     return 1
        case .list:             return 2
        case .bold, .italic:    return 3
        case .code, .link:      return 4
        default:                return 5
        }
    }
    
    public var description: String {
        switch self {
        case .none:     return "None"
        case .h1:       return "H1"
        case .h2:       return "H2"
        case .h3:       return "H3"
        case .bold:     return "Bold"
        case .italic:   return "Italic"
        case .code:     return "Code"
        case .list:     return "List"
        case .quote:    return "Quote"
        case .link:     return "Link"
        default:        return "Combined Markdown"
        }
    }
}
