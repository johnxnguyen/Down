//
//  AttributedStringVisitor.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

#if !os(Linux)

import Foundation

/// This class is used to generated an `NSMutableAttributedString` from the abstract syntax
/// tree produced by a markdown string. It traverses the tree to construct substrings
/// represented at each node and uses an instance of `Styler` to apply the visual attributes.
/// These substrings are joined together to produce the final result.

public typealias ListPrefixGeneratorBuilder = (List) -> ListItemPrefixGenerator

public class AttributedStringVisitor {

    // MARK: - Properties

    private let styler: Styler
    private let options: DownOptions
    private let listPrefixGeneratorBuilder: ListPrefixGeneratorBuilder
    private var listPrefixGenerators = [ListItemPrefixGenerator]()

    /// Creates a new instance with the given styler and options.
    ///
    /// - parameters:
    ///     - styler: used to style the markdown elements.
    ///     - options: may be used to modify rendering.
    ///     - listPrefixGeneratorBuilder: may be used to modify list prefixes.

    public init(
        styler: Styler,
        options: DownOptions = .default,
        listPrefixGeneratorBuilder: @escaping ListPrefixGeneratorBuilder = { StaticListItemPrefixGenerator(list: $0) }
    ) {
        self.styler = styler
        self.options = options
        self.listPrefixGeneratorBuilder = listPrefixGeneratorBuilder
    }

}

extension AttributedStringVisitor: Visitor {

    public typealias Result = NSMutableAttributedString

    public func visit(document node: Document) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined
        styler.style(document: result)
        return result
    }

    public func visit(blockQuote node: BlockQuote) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(blockQuote: result, nestDepth: node.nestDepth)
        return result
    }

    public func visit(list node: List) -> NSMutableAttributedString {

        listPrefixGenerators.append(listPrefixGeneratorBuilder(node))
        defer { listPrefixGenerators.removeLast() }

        let items = visitChildren(of: node)

        let result = items.joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(list: result, nestDepth: node.nestDepth)
        return result
    }

    public func visit(item node: Item) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined

        let prefix = listPrefixGenerators.last?.next() ?? "•"
        let attributedPrefix = "\(prefix)\t".attributed
        styler.style(listItemPrefix: attributedPrefix)
        result.insert(attributedPrefix, at: 0)

        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(item: result, prefixLength: (prefix as NSString).length)
        return result
    }

    public func visit(codeBlock node: CodeBlock) -> NSMutableAttributedString {
        guard let literal = node.literal else { return .empty }
        let result = literal.replacingNewlinesWithLineSeparators().attributed
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(codeBlock: result, fenceInfo: node.fenceInfo)
        return result
    }

    public func visit(htmlBlock node: HtmlBlock) -> NSMutableAttributedString {
        guard let literal = node.literal else { return .empty }
        let result = literal.replacingNewlinesWithLineSeparators().attributed
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(htmlBlock: result)
        return result
    }

    public func visit(customBlock node: CustomBlock) -> NSMutableAttributedString {
        guard let result = node.literal?.attributed else { return .empty }
        styler.style(customBlock: result)
        return result
    }

    public func visit(paragraph node: Paragraph) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(paragraph: result)
        return result
    }

    public func visit(heading node: Heading) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(heading: result, level: node.headingLevel)
        return result
    }

    public func visit(thematicBreak node: ThematicBreak) -> NSMutableAttributedString {
        let result = "\(String.zeroWidthSpace)\n".attributed
        styler.style(thematicBreak: result)
        return result
    }

    public func visit(text node: Text) -> NSMutableAttributedString {
        guard let result = node.literal?.attributed else { return .empty }
        styler.style(text: result)
        return result
    }

    public func visit(softBreak node: SoftBreak) -> NSMutableAttributedString {
        let result = (options.contains(.hardBreaks) ? String.lineSeparator : " ").attributed
        styler.style(softBreak: result)
        return result
    }

    public func visit(lineBreak node: LineBreak) -> NSMutableAttributedString {
        let result = String.lineSeparator.attributed
        styler.style(lineBreak: result)
        return result
    }

    public func visit(code node: Code) -> NSMutableAttributedString {
        guard let result = node.literal?.attributed else { return .empty }
        styler.style(code: result)
        return result
    }

    public func visit(htmlInline node: HtmlInline) -> NSMutableAttributedString {
        guard let result = node.literal?.attributed else { return .empty }
        styler.style(htmlInline: result)
        return result
    }

    public func visit(customInline node: CustomInline) -> NSMutableAttributedString {
        guard let result = node.literal?.attributed else { return .empty }
        styler.style(customInline: result)
        return result
    }

    public func visit(emphasis node: Emphasis) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined
        styler.style(emphasis: result)
        return result
    }

    public func visit(strong node: Strong) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined
        styler.style(strong: result)
        return result
    }

    public func visit(link node: Link) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined
        styler.style(link: result, title: node.title, url: node.url)
        return result
    }

    public func visit(image node: Image) -> NSMutableAttributedString {
        let result = visitChildren(of: node).joined
        styler.style(image: result, title: node.title, url: node.url)
        return result
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

#endif // !os(Linux)
