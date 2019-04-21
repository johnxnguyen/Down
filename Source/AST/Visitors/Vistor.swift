//
//  Vistor.swift
//  Down
//
//  Created by John Nguyen on 07.04.19.
//

import Foundation

/// Visitor describes a type that is able to traverse the abstract syntax tree. It visits
/// each node of the tree and produces some result for that node. A visitor is "accepted" by
/// the root node (of type `Document`), which will start the traversal by first invoking
/// `visit(document:)`.
public protocol Visitor {
    associatedtype Result
    func visit(document node: Document) -> Result
    func visit(blockQuote node: BlockQuote) -> Result
    func visit(list node: List) -> Result
    func visit(item node: Item) -> Result
    func visit(codeBlock node: CodeBlock) -> Result
    func visit(htmlBlock node: HtmlBlock) -> Result
    func visit(customBlock node: CustomBlock) -> Result
    func visit(paragraph node: Paragraph) -> Result
    func visit(heading node: Heading) -> Result
    func visit(thematicBreak node: ThematicBreak) -> Result
    func visit(text node: Text) -> Result
    func visit(softBreak node: SoftBreak) -> Result
    func visit(lineBreak node: LineBreak) -> Result
    func visit(code node: Code) -> Result
    func visit(htmlInline node: HtmlInline) -> Result
    func visit(customInline node: CustomInline) -> Result
    func visit(emphasis node: Emphasis) -> Result
    func visit(strong node: Strong) -> Result
    func visit(link node: Link) -> Result
    func visit(image node: Image) -> Result
    func visitChildren(of node: Node) -> [Result]
}

extension Visitor {
    public func visitChildren(of node: Node) -> [Result] {
        return node.children.compactMap { child in
            switch child {
            case is Document:       return visit(document: child as! Document)
            case is BlockQuote:     return visit(blockQuote: child as! BlockQuote)
            case is List:           return visit(list: child as! List)
            case is Item:           return visit(item: child as! Item)
            case is CodeBlock:      return visit(codeBlock: child as! CodeBlock)
            case is HtmlBlock:      return visit(htmlBlock: child as! HtmlBlock)
            case is CustomBlock:    return visit(customBlock: child as! CustomBlock)
            case is Paragraph:      return visit(paragraph: child as! Paragraph)
            case is Heading:        return visit(heading: child as! Heading)
            case is ThematicBreak:  return visit(thematicBreak: child as! ThematicBreak)
            case is Text:           return visit(text: child as! Text)
            case is SoftBreak:      return visit(softBreak: child as! SoftBreak)
            case is LineBreak:      return visit(lineBreak: child as! LineBreak)
            case is Code:           return visit(code: child as! Code)
            case is HtmlInline:     return visit(htmlInline: child as! HtmlInline)
            case is CustomInline:   return visit(customInline: child as! CustomInline)
            case is Emphasis:       return visit(emphasis: child as! Emphasis)
            case is Strong:         return visit(strong: child as! Strong)
            case is Link:           return visit(link: child as! Link)
            case is Image:          return visit(image: child as! Image)
            default:
                assertionFailure("Unexpected child")
                return nil
            }
        }
    }
}
