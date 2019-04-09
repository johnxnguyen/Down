//
//  DebugVisitor.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation

public class DebugVisitor {
    
    weak var document: Document?
    
    var result: Result? {
        guard let document = document else { return nil }
        return visit(document: document)
    }
    
    init(document: Document) {
        self.document = document
    }
    
    private func report(_ node: Node) -> String {
        return String(reflecting: node)
    }
    
    private func reportWithChildren(_ node: Node) -> String {
        return "\(node) -> [\(visitChildren(of: node).joined(separator: ", "))]"
    }
}

extension DebugVisitor: Visitor {
    typealias Result = String
    
    func visit(document node: Document) -> String {
        return reportWithChildren(node)
    }
    
    func visit(blockQuote node: BlockQuote) -> String {
        return reportWithChildren(node)
    }
    
    func visit(list node: List) -> String {
        return reportWithChildren(node)
    }
    
    func visit(item node: Item) -> String {
        return reportWithChildren(node)
    }
    
    func visit(codeBlock node: CodeBlock) -> String {
        return reportWithChildren(node)
    }
    
    func visit(htmlBlock node: HtmlBlock) -> String {
        return reportWithChildren(node)
    }
    
    func visit(customBlock node: CustomBlock) -> String {
        return reportWithChildren(node)
    }
    
    func visit(paragraph node: Paragraph) -> String {
        return reportWithChildren(node)
    }
    
    func visit(heading node: Heading) -> String {
        return report(node)
    }
    
    func visit(thematicBreak node: ThematicBreak) -> String {
        return report(node)
    }
    
    func visit(text node: Text) -> String {
        return report(node)
    }
    
    func visit(softBreak node: SoftBreak) -> String {
        return report(node)
    }
    
    func visit(lineBreak node: LineBreak) -> String {
        return report(node)
    }
    
    func visit(code node: Code) -> String {
        return report(node)
    }
    
    func visit(htmlInline node: HtmlInline) -> String {
        return report(node)
    }
    
    func visit(customInline node: CustomInline) -> String {
        return report(node)
    }
    
    func visit(emphasis node: Emphasis) -> String {
        return reportWithChildren(node)
    }
    
    func visit(strong node: Strong) -> String {
        return reportWithChildren(node)
    }
    
    func visit(link node: Link) -> String {
        return reportWithChildren(node)
    }
    
    func visit(image node: Image) -> String {
        return reportWithChildren(node)
    }
}
