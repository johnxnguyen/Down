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
    private var listStack = [ListItemPrefixGenerator]()

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
        styler.style(blockQuote: s)
        return s
    }

    public func visit(list node: List) -> NSMutableAttributedString {
        listStack.append(ListItemPrefixGenerator(list: node))

        let items = visitChildren(of: node)

        listStack.removeLast()

        let s = items.joined
        if node.hasSuccessor { s.append(.paragraphSeparator) }
        styler.style(list: s, nestDepth: node.nestDepth)

        s.replaceAttribute(.listMarker, value: ())

        return s
    }
    
    public func visit(item node: Item) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined

        let prefix = listStack.last?.next() ?? "•"

        let attributedPrefix = "\(prefix)\t".attributed
        styler.style(listItemPrefix: attributedPrefix)
        s.insert(attributedPrefix, at: 0)

        if node.hasSuccessor { s.append(.paragraphSeparator) }

        styler.style(item: s, prefixLength: (prefix as NSString).length, nestDepth: node.nestDepth)

        return s
    }
    
    public func visit(codeBlock node: CodeBlock) -> NSMutableAttributedString {
        guard let literal = node.literal else { return .empty }
        let block = literal.replacingNewlinesWithLineSeparators() + "\n"
        let s = block.attributed
        styler.style(codeBlock: s, fenceInfo: node.fenceInfo)
        return s
    }
    
    public func visit(htmlBlock node: HtmlBlock) -> NSMutableAttributedString {
        guard let literal = node.literal else { return .empty }
        let block = literal.replacingNewlinesWithLineSeparators() + "\n"
        let s = block.attributed
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
        styler.style(paragraph: s, isTopLevel: node.isTopLevel)
        return s
    }
    
    public func visit(heading node: Heading) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if node.hasSuccessor { s.append(.paragraphSeparator) }
        styler.style(heading: s, level: node.headingLevel)
        return s
    }
    
    public func visit(thematicBreak node: ThematicBreak) -> NSMutableAttributedString {
        let s = "\(String.zeroWidthSpace)\(String.lineSeparator)".attributed
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

// TODO: I'd like to move these into separate files.

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
// TODO: move this to string extension
private extension NSAttributedString {
    static var paragraphSeparator: NSAttributedString {
        return "\u{2029}".attributed
    }
}

private extension NSMutableAttributedString {
    static var empty: NSMutableAttributedString {
        return "".attributed
    }
}

private extension String {
    // https://lists.apple.com/archives/Cocoa-dev/2010/Dec/msg00347.html
    static var lineSeparator: String {
        return "\u{2028}"
    }

    static var zeroWidthSpace: String {
        return "\u{200B}"
    }

    func replacingNewlinesWithLineSeparators() -> String {
        return components(separatedBy: .newlines).joined(separator: .lineSeparator)
    }
}
