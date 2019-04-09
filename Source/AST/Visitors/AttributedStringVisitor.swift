//
//  AttributedStringVisitor.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation

protocol Styler {
    func style(document str: NSMutableAttributedString)
    func style(blockQuote str: NSMutableAttributedString)
    func style(list str: NSMutableAttributedString)
    func style(item str: NSMutableAttributedString)
    func style(codeBlock str: NSMutableAttributedString)
    func style(htmlBlock str: NSMutableAttributedString)
    func style(customBlock str: NSMutableAttributedString)
    func style(paragraph str: NSMutableAttributedString)
    func style(heading str: NSMutableAttributedString)
    func style(thematicBreak str: NSMutableAttributedString)
    func style(text str: NSMutableAttributedString)
    func style(softBreak str: NSMutableAttributedString)
    func style(lineBreak str: NSMutableAttributedString)
    func style(code str: NSMutableAttributedString)
    func style(htmlInline str: NSMutableAttributedString)
    func style(customInline str: NSMutableAttributedString)
    func style(emphasis str: NSMutableAttributedString)
    func style(strong str: NSMutableAttributedString)
    func style(link str: NSMutableAttributedString)
    func style(image str: NSMutableAttributedString)
}

public class AttributedStringVisitor {
    
    private let styler: Styler
    private let options: DownOptions
    
    init(styler: Styler, options: DownOptions = .default) {
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
        fatalError("unimplemented")
    }
    
    public func visit(list node: List) -> NSMutableAttributedString {
        fatalError("unimplemented")
    }
    
    public func visit(item node: Item) -> NSMutableAttributedString {
        fatalError("unimplemented")
    }
    
    public func visit(codeBlock node: CodeBlock) -> NSMutableAttributedString {
        fatalError("unimplemented")
    }
    
    public func visit(htmlBlock node: HtmlBlock) -> NSMutableAttributedString {
        fatalError("unimplemented")
    }
    
    public func visit(customBlock node: CustomBlock) -> NSMutableAttributedString {
        fatalError("unimplemented")
    }
    
    public func visit(paragraph node: Paragraph) -> NSMutableAttributedString {
        let s = visitChildren(of: node).joined
        styler.style(paragraph: s)
        return s
    }
    
    public func visit(heading node: Heading) -> NSMutableAttributedString {
        fatalError("unimplemented")
    }
    
    public func visit(thematicBreak node: ThematicBreak) -> NSMutableAttributedString {
        fatalError("unimplemented")
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
        fatalError("unimplemented")
    }
    
    public func visit(customInline node: CustomInline) -> NSMutableAttributedString {
        fatalError("unimplemented")
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
        return reduce(into: NSMutableAttributedString()) { (acc, next) in
            acc.append(next)
        }
    }
}
