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

// Inspired by: https://github.com/chriseidhof/commonmark-swift

import UIKit
import Foundation
import libcmark

// Maybe it makes sense to insert empty string if no literal

protocol Renderable {
    func render(with style: Style) -> NSMutableAttributedString?
}

enum ListType : CustomStringConvertible {
    case ordered(start: Int)
    case unordered
    
    func prefix(itemIndex: Int) -> String {
        switch self {
        case .ordered(let start):   return "\(start + itemIndex). "
        case .unordered:            return "• "
        }
    }
    
    var description: String {
        switch self {
        case .ordered(let start): return "Ordered: Start: \(start)"
        case .unordered: return "Unordered"
        }
    }
}

// MARK: - BLOCK DEFINITION

enum Block {
    case document(children: [Block])
    case blockQuote(items: [Block])
    case list(items: [Block], type: ListType) // 2D array for nested lists?
    case listItem(children: [Block], prefix: String)
    case codeBlock(text: String)
    case htmlBlock(text: String)
    case customBlock(literal: String)    // ???
    case paragraph(children: [Inline])
    case heading(children: [Inline], level: Int)
    case thematicBreak
}

// MARK: - INLINE DEFINITION

enum Inline {
    case text(text: String)
    case softBreak
    case lineBreak
    case code(text: String)
    case html(text: String)
    case custom(literal: String) // ???
    case emphasis(children: [Inline])
    case strong(children: [Inline])
    case link(children: [Inline], title: String?, url: String?)
    case image(children: [Inline], title: String?, url: String?)
}

// MARK: - BLOCK INIT

extension Block {
    init(_ node: Node) {
        let inlineChildren = { node.children.map(Inline.init) }
        let blockChildren = { node.children.map(Block.init) }
        
        switch node.type {
        case CMARK_NODE_DOCUMENT:
            self = .document(children: blockChildren())
            
        case CMARK_NODE_BLOCK_QUOTE:
            self = .blockQuote(items: blockChildren())
            
        case CMARK_NODE_LIST:
            let listType: ListType
            switch node.listType {
            case CMARK_ORDERED_LIST: listType = .ordered(start: node.listStart)
            default: listType = .unordered
            }
            
            var items = [Block]()
            for (idx, item) in node.children.enumerated() {
                items.append(.listItem(children: item.children.map(Block.init), prefix: listType.prefix(itemIndex: idx)))
            }
            
            self = .list(items: items, type: listType)
            
        case CMARK_NODE_ITEM:
            fatalError("Can't create list item here!")
            
        case CMARK_NODE_CODE_BLOCK:
            self = .codeBlock(text: node.literal!)
            
        case CMARK_NODE_HTML_BLOCK:
            self = .htmlBlock(text: node.literal!)
            
        case CMARK_NODE_CUSTOM_BLOCK:
            self = .customBlock(literal: node.literal!)
            
        case CMARK_NODE_PARAGRAPH:
            self = .paragraph(children: inlineChildren())
            
        case CMARK_NODE_HEADING:
            self = .heading(children: inlineChildren(), level: node.headerLevel)
            
        case CMARK_NODE_THEMATIC_BREAK:
            self = .thematicBreak
            
        default:
            fatalError("Unknown node: \(node.typeString)")
        }
    }
    
}


// MARK: - INLINE INIT

extension Inline {
    init(_ node: Node) {
        let inlineChildren = { node.children.map(Inline.init) }
        
        switch node.type {
        case CMARK_NODE_TEXT:
            self = .text(text: node.literal!)
            
        case CMARK_NODE_SOFTBREAK:
            self = .softBreak
            
        case CMARK_NODE_LINEBREAK:
            self = .lineBreak
            
        case CMARK_NODE_CODE:
            self = .code(text: node.literal!)
            
        case CMARK_NODE_HTML_INLINE:
            self = .html(text: node.literal!)
            
        case CMARK_NODE_CUSTOM_INLINE:
            self = .custom(literal: node.literal!)
            
        case CMARK_NODE_EMPH:
            self = .emphasis(children: inlineChildren())
            
        case CMARK_NODE_STRONG:
            self = .strong(children: inlineChildren())
            
        case CMARK_NODE_LINK:
            self = .link(children: inlineChildren(), title: node.title, url: node.urlString)
            
        case CMARK_NODE_IMAGE:
            self = .image(children: inlineChildren(), title: node.title, url: node.urlString)
            
        default:
            fatalError("Unknown node: \(node.typeString)")
        }
    }
}

// MARK: - BLOCK RENDER

extension Block : Renderable {
    /// Renders the tree rooted at the current node.
    func render(with style: Style) -> NSMutableAttributedString? {
        let attrs = style.attributes(for: self)
        switch self {
        case .document(let children):
            return children.map { $0.render(with: style) }.join()
            
        case .blockQuote(let items):
            let content = items.map { $0.render(with: style) }.join()
            content.addAttributes(attrs)
            return content
            
        case .list(let items, type: _):
            let content = items.map { $0.render(with: style) }.join()
            // paragraph indentation should be accumulative!
            let ranges = content.rangesOfNestedLists
            content.addAttributes(attrs)
            // reapply nested list attributes
            let nestedListStyle = style.listParagraphStyle.indentedBy(points: 24)
            ranges.forEach {
                content.addAttribute(.paragraphStyle, value: nestedListStyle, range: $0)
            }
            return content
            
        case .listItem(let children, let prefix):
            // need to add style!
            let content = children.map { $0.render(with: style) }.join()
            let attrPrefix = NSMutableAttributedString(string: prefix, attributes: style.codeAttributes)
            return [attrPrefix, content].join()
            
        case .codeBlock(let text):
            return NSMutableAttributedString(string: text, attributes: attrs)
            
        case .htmlBlock(let text):
            return NSMutableAttributedString(string: text, attributes: attrs)
            
        case .customBlock(let literal):
            return NSMutableAttributedString(string: literal, attributes: attrs)
            
        case .paragraph(let children):
            let content = children.map { $0.render(with: style) }.join()
            content.appendBreak()
            return content
            
        case .heading(let children, let level):
            // need to add style!
            let content = children.map { $0.render(with: style) }.join()
            content.deepAddHeader(with: style.headerSize(for: level))
            content.appendBreak()
            content.addAttributes(attrs)
            return content
            
        case .thematicBreak:
            return nil
        }
    }
}

// MARK: - INLINE RENDER

extension Inline : Renderable {
    func render(with style: Style) -> NSMutableAttributedString? {
        let attrs = style.attributes(for: self)
        switch self {
        case .text(let text):
            return NSMutableAttributedString(string: text, attributes: attrs)
            
        case .softBreak:
            return NSMutableAttributedString(string: " ")
            
        case .lineBreak:
            return NSMutableAttributedString(string: "\n")
            
        case .code(let text):
            return NSMutableAttributedString(string: text, attributes: attrs)
            
        case .html(let text):
            return NSMutableAttributedString(string: text, attributes: attrs)
            
        case .custom(let literal):
            return NSMutableAttributedString(string: literal, attributes: attrs)
            
        case .emphasis(let children):
            let content = children.map { $0.render(with: style) }.join()
            content.deppAddItalic()
            if let attrs = attrs { content.addAttributes(attrs, range: content.wholeRange) }
            return content
            
        case .strong(let children):
            let content = children.map { $0.render(with: style) }.join()
            content.deepAddBold()
            if let attrs = attrs { content.addAttributes(attrs, range: content.wholeRange) }
            return content
            
        case .link(let children, title: _, url: _):
            let content = children.map { $0.render(with: style) }.join()
            // MISSING ATTRIBUTES
            return content
            
        case .image(let children, title: _, url: _):
            let content = children.map { $0.render(with: style) }.join()
            // MISSING ATTRIBUTES
            return content
        }
    }
}

// MARK: - BLOCK DESCRIPTION

extension Block : CustomStringConvertible {
    /// Describes the tree rooted at this node.
    var description: String {
        return description(indent: 0)
    }
    
    /// Returns the description with the given indentation.
    func description(indent: Int) -> String {
        var str: String
        let describeBlockChildren: (Block) -> String = { $0.description(indent: indent + 1) }
        let describeInlineChildren: (Inline) -> String = { $0.description(indent: indent + 1) }
        
        switch self {
        case .document(let children):
            str = "DOCUMENT ->\n" + children.flatMap(describeBlockChildren)
            
        case .blockQuote(let items):
            str = "BLOCK QUOTE ->\n" + items.flatMap(describeBlockChildren)
            
        case .list(let items, let type):
            
            str = "LIST: \(type) ->\n" + items.flatMap(describeBlockChildren)
            
        case .listItem(let children, let prefix):
            str = "ITEM: Prefix: \(prefix) ->\n" + children.flatMap(describeBlockChildren)
            
        case .codeBlock(let text):
            str = "CODE BLOCK: \(text)\n"
            
        case .htmlBlock(let text):
            str = "HTML BLOCK: \(text)\n"
            
        case .customBlock(let literal):
            str = "CUSTOM BLOCK: \(literal)\n"
            
        case .paragraph(let children):
            str = "PARAGRAPH ->\n" + children.flatMap(describeInlineChildren)
            
        case .heading(let children, let level):
            str = "H\(level) HEADING ->\n" + children.flatMap(describeInlineChildren)
            
        case .thematicBreak:
            str = "THEMATIC BREAK ->\n"
        }
        
        return String(repeating: "\t", count: indent) + str
    }
}

// MARK: - INLINE DESCRIPTION

extension Inline : CustomStringConvertible {
    /// Describes the tree rooted at this node.
    var description: String {
        return description(indent: 0)
    }
    
    /// Returns the description with the given indentation.
    func description(indent: Int) -> String {
        var str: String
        let describeChildren: (Inline) -> String = { $0.description(indent: indent + 1) }
        
        switch self {
        case .text(let text):
            str = "TEXT: \(text)\n"
            
        case .softBreak:
            str = "SOFT BREAK\n"
            
        case .lineBreak:
            str = "LINE BREAK\n"
            
        case .code(let text):
            str = "CODE: \(text)\n"
            
        case .html(let text):
            str = "HTML: \(text)\n"
            
        case .custom(let literal):
            str = "CUSTOM INLINE: \(literal)\n"
            
        case .emphasis(let children):
            str = "EMPHASIS ->\n" + children.flatMap(describeChildren)
            
        case .strong(let children):
            str = "STRONG ->\n" + children.flatMap(describeChildren)
            
        case .link(let children, let title, let url):
            str = "LINK: Title: \(title ?? "none"), URL: \(url ?? "none") ->\n" + children.flatMap(describeChildren)
            
        case .image(let children, let title, let url):
            str = "IMAGE: Title: \(title ?? "none"), URL: \(url ?? "none") ->\n" + children.flatMap(describeChildren)
        }
        
        return String(repeating: "\t", count: indent) + str
    }
}

