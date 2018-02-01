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

// MARK: - DEFINITIONS

protocol Renderable {
    func render(with style: Style) -> NSMutableAttributedString?
}

enum ListType : CustomStringConvertible {
    case ordered(start: Int)
    case unordered
    
    init?(node: Node) {
        guard node.type == CMARK_NODE_LIST else { return nil }
        switch node.listType {
        case CMARK_ORDERED_LIST:    self = .ordered(start: node.listStart)
        default:                    self = .unordered
        }
    }
    
    /// Returns the prefix for the this lists item at the given index.
    func prefix(itemIndex: Int) -> String {
        // the tabs are used to align the list item content
        switch self {
        case .ordered(let start):   return "\(start + itemIndex).\t"
        case .unordered:            return "•\t"
        }
    }
    
    var description: String {
        switch self {
        case .ordered(let start):   return "Ordered: Start: \(start)"
        case .unordered:            return "Unordered"
        }
    }
}

enum Block {
    case document(children: [Block])
    case blockQuote(items: [Block])
    case list(items: [Block], type: ListType)
    case listItem(children: [Block], prefix: String)
    case codeBlock(text: String)
    case htmlBlock(text: String)
    case customBlock(literal: String)
    case paragraph(children: [Inline])
    case heading(children: [Inline], level: Int)
    case thematicBreak
}

enum Inline {
    case text(text: String)
    case softBreak
    case lineBreak
    case code(text: String)
    case html(text: String)
    case custom(literal: String)
    case emphasis(children: [Inline])
    case strong(children: [Inline])
    case link(children: [Inline], title: String?, url: String?)
    case image(children: [Inline], title: String?, url: String?)
}

// MARK: - INITIALIZERS

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
            let listType = ListType(node: node) ?? .ordered(start: 0)
            
            // we process the lists items here so that we can append their prefixes
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

// MARK: - RENDER HELPERS

fileprivate extension Sequence where Iterator.Element == Block {
    /// Calls render(with style:) to each element in the sequence and returns
    /// the concatenation of their results.
    func render(with style: Style) -> NSMutableAttributedString {
        return self.map { $0.render(with: style) }.join()
    }
}

fileprivate extension Sequence where Iterator.Element == Inline {
    /// Calls render(with style:) to each element in the sequence and returns
    /// the concatenation of their results.
    func render(with style: Style) -> NSMutableAttributedString {
        return self.map { $0.render(with: style) }.join()
    }
}

// MARK: - RENDERING

extension Block : Renderable {
    /// Renders the tree rooted at the current node with the given style.
    func render(with style: Style) -> NSMutableAttributedString? {
        let attrs = style.attributes(for: self)
        
        switch self {
        case .document(let children):
            return children.render(with: style)
            
        case .blockQuote(let items):
            let content = items.render(with: style)
            content.addAttributes(attrs)
            return content
            
        case .list(let items, type: let type):
            // TODO: general tidy up
            let content = items.render(with: style)
            // find ranges of existing nested lists (we must do this before
            // applying new attributes)
            let ranges = content.ranges(containing: .list)
            
            content.addAttributes(attrs)
            
            // calculate size of prefix in points
            var prefixWidth: CGFloat?
            if let lastItem = items.last {
                // last item will be the largest (if it's ordered)
                switch lastItem {
                case .listItem(_, let prefix):
                    let trimmed = prefix.trimmingCharacters(in: .whitespaces)
                    let size = trimmed.size(withAttributes: style.codeAttributes)
                    prefixWidth = ceil(size.width)
                default: break
                }
            }
            
            // the style for this outer list
            let paragraphStyle = style.listParagraphStyle(with: prefixWidth!)
            // the indentation of the list item content (after the prefix)
            let indentation = paragraphStyle.headIndent
            
            // get the existing paragraph styles & ranges for the nested lists
            var existingStyles: [(NSParagraphStyle, NSRange)] = []
            ranges.forEach {
                let val = content.attribute(.paragraphStyle, at: $0.location, effectiveRange: nil)
                if let old = val as? NSParagraphStyle {
                    let new = old.indentedBy(points: indentation - style.listIndentation)
                    existingStyles.append((new, $0))
                }
            }
            
            // apply the outer list paragraph style
            content.addAttributes([.paragraphStyle: paragraphStyle])
            
            // apply the updated paragraph styles for the inner lists
            for (val, range) in existingStyles {
                content.addAttribute(.paragraphStyle, value: val, range: range)
            }
            
            return content
            
        case .listItem(let children, let prefix):
            let content = children.render(with: style)
            let attrPrefix = NSMutableAttributedString(string: prefix, attributes: style.codeAttributes)
            return [attrPrefix, content].join()
            
        case .codeBlock(let text):
            return NSMutableAttributedString(string: text, attributes: attrs)
            
        case .htmlBlock(let text):
            return NSMutableAttributedString(string: text, attributes: attrs)
            
        case .customBlock(let literal):
            return NSMutableAttributedString(string: literal, attributes: attrs)
            
        case .paragraph(let children):
            let content = children.render(with: style)
            content.appendBreak()
            return content
            
        case .heading(let children, let level):
            let content = children.render(with: style)
            content.bolden(with: style.headerSize(for: level))
            content.addAttributes(attrs)
            content.appendBreak()
            return content
            
        case .thematicBreak:
            // TODO: should this be nil?
            return nil
        }
    }
}

extension Inline : Renderable {
    /// Renders the tree rooted at the current node with the given style.
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
            let content = children.render(with: style)
            content.italicize()
            content.addAttributes(attrs)
            return content
            
        case .strong(let children):
            let content = children.render(with: style)
            content.bolden()
            content.addAttributes(attrs)
            return content
            
        case .link(let children, title: _, let url):
            let content = children.render(with: style)
            if let url = url {
                content.addAttribute(.markdown, value: Markdown.list, range: content.wholeRange)
                content.addAttribute(.link, value: url, range: content.wholeRange)
            }
            return content
            
        case .image(let children, title: _, url: _):
            let content = children.render(with: style)
            // TODO: attributes
            return content
        }
    }
}

// MARK: - STRING DESCRIPTION

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
