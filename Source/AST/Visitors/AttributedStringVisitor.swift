//
//  AttributedStringVisitor.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation

/// This class is used to generated an `NSMutableAttributedString` from the abstract syntax
/// tree produced by a markdown string. It traverses the tree to construct substrings
/// represented at each node and uses an instance of `Styler` to apply the visual attributes.
/// These substrings are joined together to produce the final result.
public class AttributedStringVisitor {
    
    private let styler: Styler
    private let options: DownOptions
    
    /// Creates a new instance with the given styler and options.
    ///
    /// - parameters:
    ///     - styler: used to style the markdown elements.
    ///     - options: may be used to modify rendering.
    public init(styler: Styler, options: DownOptions = .default) {
        self.styler = styler
        self.options = options
    }
}

extension AttributedStringVisitor: Visitor {
    public typealias Result = NSMutableAttributedString
    
    public func visit(document node: Document) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        styler.style(document: s)
        return s
    }
    
    public func visit(blockQuote node: BlockQuote) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if node.hasSuccessor { s.append(.blankLine) }
        styler.style(blockQuote: s)
        return s
    }
    
    public func visit(list node: List) -> NSMutableAttributedString {
        let items = visitChildren(of: node)
        
        // Prepend prefixes to each item.
        items.enumerated().forEach { index, item in
            let prefix: String
            switch node.listType {
            case .bullet: prefix = "•\t"
            case .ordered(let start): prefix = "\(start + index).\t"
            }
            
            let attrPrefix = NSAttributedString(string: prefix, attributes: styler.listPrefixAttributes)
            item.insert(attrPrefix, at: 0)
        }
        
        let s = items.joined
        if node.hasSuccessor { s.append(.blankLine) }
        styler.style(list: s)
        return s
    }
    
    public func visit(item node: Item) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if node.hasSuccessor { s.append(.blankLine) }
        styler.style(item: s)
        return s
    }
    
    public func visit(codeBlock node: CodeBlock) -> NSMutableAttributedString {
        guard let s = node.literal?.attributed else { return .empty }
        styler.style(codeBlock: s, fenceInfo: node.fenceInfo)
        return s
    }
    
    public func visit(htmlBlock node: HtmlBlock) -> NSMutableAttributedString {
        guard let s = node.literal?.attributed else { return .empty }
        styler.style(htmlBlock: s)
        return s
    }
    
    public func visit(customBlock node: CustomBlock) -> NSMutableAttributedString {
        guard let s = node.literal?.attributed else { return .empty }
        styler.style(customBlock: s)
        return s
    }
    
    public func visit(paragraph node: Paragraph) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if node.hasSuccessor { s.append(.blankLine) }
        styler.style(paragraph: s)
        return s
    }
    
    public func visit(heading node: Heading) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if node.hasSuccessor { s.append(.blankLine) }
        styler.style(heading: s, level: node.headingLevel)
        return s
    }
    
    public func visit(thematicBreak node: ThematicBreak) -> NSMutableAttributedString {
        let s = "\n".attributed
        styler.style(thematicBreak: s)
        return s
    }
    
    public func visit(text node: Text) -> NSMutableAttributedString {
        guard let s = node.literal?.attributed else { return .empty }
        styler.style(text: s)
        return s
    }
    
    public func visit(softBreak node: SoftBreak) -> NSMutableAttributedString {
        let s = (options.contains(.hardBreaks) ? "\n" : " ").attributed
        styler.style(softBreak: s)
        return s
    }
    
    public func visit(lineBreak node: LineBreak) -> NSMutableAttributedString {
        let s = "\n".attributed
        styler.style(lineBreak: s)
        return s
    }
    
    public func visit(code node: Code) -> NSMutableAttributedString {
        guard let s = node.literal?.attributed else { return .empty }
        styler.style(code: s)
        return s
    }
    
    public func visit(htmlInline node: HtmlInline) -> NSMutableAttributedString {
        guard let s = node.literal?.attributed else { return .empty }
        styler.style(htmlInline: s)
        return s
    }
    
    public func visit(customInline node: CustomInline) -> NSMutableAttributedString {
        guard let s = node.literal?.attributed else { return .empty }
        styler.style(customInline: s)
        return s
    }
    
    public func visit(emphasis node: Emphasis) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        styler.style(emphasis: s)
        return s
    }
    
    public func visit(strong node: Strong) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        styler.style(strong: s)
        return s
    }
    
    public func visit(link node: Link) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        styler.style(link: s, title: node.title, url: node.url)
        return s
    }
    
    public func visit(image node: Image) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        styler.style(image: s, title: node.title, url: node.url)
        return s
    }
}

// MARK: - Helper extentions

private extension Sequence where Iterator.Element == NSMutableAttributedString {
    var joined: NSMutableAttributedString {
        return reduce(into: NSMutableAttributedString()) { $0.append($1) }
    }
}

private extension String {
    var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}

private extension NSAttributedString {
    static var blankLine: NSAttributedString {
        return "\n".attributed
    }
}

private extension NSMutableAttributedString {
    static var empty: NSMutableAttributedString {
        return "".attributed
    }
}
