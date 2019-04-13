//
//  AttributedStringVisitor.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation


public class AttributedStringVisitor {
    
    private let styler: Styler
    private let options: DownOptions
    
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
        if !node.isLast { s.append(.blankLine) }
        styler.style(blockQuote: s)
        return s
    }
    
    public func visit(list node: List) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        s.append(.blankLine)
        styler.style(list: s)
        return s
    }
    
    public func visit(item node: Item) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if !node.isLast { s.append(.blankLine) }
        styler.style(item: s)
        return s
    }
    
    public func visit(codeBlock node: CodeBlock) -> NSMutableAttributedString {
        let s = node.literal.attributed
        if !node.isLast { s.append(.blankLine) }
        styler.style(codeBlock: s)
        return s
    }
    
    public func visit(htmlBlock node: HtmlBlock) -> NSMutableAttributedString {
        let s = node.literal.attributed
        s.insert(.blankLine, at: 0)
        if !node.isLast { s.append(.blankLine) }
        styler.style(htmlBlock: s)
        return s
    }
    
    public func visit(customBlock node: CustomBlock) -> NSMutableAttributedString {
        let s = node.literal.attributed
        s.insert(.blankLine, at: 0)
        if !node.isLast { s.append(.blankLine) }
        styler.style(customBlock: s)
        return s
    }
    
    public func visit(paragraph node: Paragraph) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if !node.isLast { s.append(.blankLine) }
        styler.style(paragraph: s)
        return s
    }
    
    public func visit(heading node: Heading) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        if !node.isLast { s.append(.blankLine) }
        styler.style(heading: s, level: node.headerLevel)
        return s
    }
    
    public func visit(thematicBreak node: ThematicBreak) -> NSMutableAttributedString {
        let s = "-----".attributed // TODO: allow this to be configurable.
        styler.style(thematicBreak: s)
        return s
    }
    
    public func visit(text node: Text) -> NSMutableAttributedString {
        let s = node.literal.attributed
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
        let s = node.literal.attributed
        styler.style(code: s)
        return s
    }
    
    public func visit(htmlInline node: HtmlInline) -> NSMutableAttributedString {
        let s = node.literal.attributed
        styler.style(htmlInline: s)
        return s
    }
    
    public func visit(customInline node: CustomInline) -> NSMutableAttributedString {
        let s = node.literal.attributed
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
        styler.style(link: s)
        return s
    }
    
    public func visit(image node: Image) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        styler.style(image: s)
        return s
    }
}


private extension String {
    var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}


private extension Sequence where Iterator.Element == NSMutableAttributedString {
    var joined: NSMutableAttributedString {
        return reduce(into: NSMutableAttributedString()) { $0.append($1) }
    }
}


private extension NSAttributedString {
    static var blankLine: NSAttributedString {
        return "\n".attributed
    }
}
