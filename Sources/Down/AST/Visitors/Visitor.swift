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
        return node.childSequence.compactMap { child in
            switch child {
            case let child as Document:       return visit(document: child)
            case let child as BlockQuote:     return visit(blockQuote: child)
            case let child as List:           return visit(list: child)
            case let child as Item:           return visit(item: child)
            case let child as CodeBlock:      return visit(codeBlock: child)
            case let child as HtmlBlock:      return visit(htmlBlock: child)
            case let child as CustomBlock:    return visit(customBlock: child)
            case let child as Paragraph:      return visit(paragraph: child)
            case let child as Heading:        return visit(heading: child)
            case let child as ThematicBreak:  return visit(thematicBreak: child)
            case let child as Text:           return visit(text: child)
            case let child as SoftBreak:      return visit(softBreak: child)
            case let child as LineBreak:      return visit(lineBreak: child)
            case let child as Code:           return visit(code: child)
            case let child as HtmlInline:     return visit(htmlInline: child)
            case let child as CustomInline:   return visit(customInline: child)
            case let child as Emphasis:       return visit(emphasis: child)
            case let child as Strong:         return visit(strong: child)
            case let child as Link:           return visit(link: child)
            case let child as Image:          return visit(image: child)
            default:
                assertionFailure("Unexpected child")
                return nil
            }
        }
    }

}
