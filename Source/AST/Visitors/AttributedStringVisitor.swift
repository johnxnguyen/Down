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
    private var listPrefixGenerators = [ListItemPrefixGenerator]()

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
        if node.hasSuccessor { s.append(.paragraphSeparator) }
        styler.style(blockQuote: s, nestDepth: node.nestDepth)
        return s
    }

    public func visit(list node: List) -> NSMutableAttributedString {
        listPrefixGenerators.append(ListItemPrefixGenerator(list: node))
        defer { listPrefixGenerators.removeLast() }

        let items = visitChildren(of: node)

        let s = items.joined
        if node.hasSuccessor { s.append(.paragraphSeparator) }
        styler.style(list: s, nestDepth: node.nestDepth)
        return s
    }
    
    public func visit(item node: Item) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined

        let prefix = listPrefixGenerators.last?.next() ?? "•"
        let attributedPrefix = "\(prefix)\t".attributed
        styler.style(listItemPrefix: attributedPrefix)
        s.insert(attributedPrefix, at: 0)

        if node.hasSuccessor { s.append(.paragraphSeparator) }
        styler.style(item: s, prefixLength: (prefix as NSString).length)
        return s
    }
    
    public func visit(codeBlock node: CodeBlock) -> NSMutableAttributedString {
        guard let literal = node.literal else { return .empty }
        let s = literal.replacingNewlinesWithLineSeparators().attributed
        if node.hasSuccessor { s.append(.paragraphSeparator) }
        styler.style(codeBlock: s, fenceInfo: node.fenceInfo)
        return s
    }
    
    public func visit(htmlBlock node: HtmlBlock) -> NSMutableAttributedString {
        guard let literal = node.literal else { return .empty }
        let s = literal.replacingNewlinesWithLineSeparators().attributed
        if node.hasSuccessor { s.append(.paragraphSeparator) }
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
        if node.hasSuccessor { s.append(.paragraphSeparator) }
        styler.style(paragraph: s)
        return s
    }
    
    public func visit(heading node: Heading) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if node.hasSuccessor { s.append(.paragraphSeparator) }
        styler.style(heading: s, level: node.headingLevel)
        return s
    }
    
    public func visit(thematicBreak node: ThematicBreak) -> NSMutableAttributedString {
        let s = "\(String.zeroWidthSpace)\n".attributed
        styler.style(thematicBreak: s)
        return s
    }
    
    public func visit(text node: Text) -> NSMutableAttributedString {
        guard let s = node.literal?.attributed else { return .empty }
        styler.style(text: s)
        return s
    }
    
    public func visit(softBreak node: SoftBreak) -> NSMutableAttributedString {
        let s = (options.contains(.hardBreaks) ? String.lineSeparator : " ").attributed
        styler.style(softBreak: s)
        return s
    }
    
    public func visit(lineBreak node: LineBreak) -> NSMutableAttributedString {
        let s = String.lineSeparator.attributed
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

// MARK: - Helper extensions

private extension Sequence where Iterator.Element == NSMutableAttributedString {

    var joined: NSMutableAttributedString {
        return reduce(into: NSMutableAttributedString()) { $0.append($1) }
    }
}

private extension NSMutableAttributedString {

    static var empty: NSMutableAttributedString {
        return "".attributed
    }
}

private extension NSAttributedString {

    static var paragraphSeparator: NSAttributedString {
        return String.paragraphSeparator.attributed
    }
}

private extension String {

    var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }

    // This codepoint marks the end of a paragraph and the start of the next.
    static var paragraphSeparator: String {
        return "\u{2029}"
    }

    // This code point allows line breaking, without starting a new paragraph.
    static var lineSeparator: String {
        return "\u{2028}"
    }

    static var zeroWidthSpace: String {
        return "\u{200B}"
    }

    func replacingNewlinesWithLineSeparators() -> String {
        let trimmed = trimmingCharacters(in: .newlines)
        let lines = trimmed.components(separatedBy: .newlines)
        return lines.joined(separator: .lineSeparator)
    }
}
