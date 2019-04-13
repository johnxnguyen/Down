//
//  Node.swift
//  Down
//
//  Created by John Nguyen on 07.04.19.
//

import Foundation
import libcmark

public typealias CMarkNode = UnsafeMutablePointer<cmark_node>

extension UnsafeMutablePointer where Pointee == cmark_node {
    var type: cmark_node_type { return cmark_node_get_type(self) }
}

public protocol Node: CustomDebugStringConvertible {
    var cmarkNode: CMarkNode { get }
    var childen: [Node] { get }
}

extension Node {
    
    public var isLast: Bool {
        return cmark_node_next(cmarkNode) == nil
    }
    
    public var childen: [Node] {
        var result: [Node] = []
        var child = cmark_node_first_child(cmarkNode)
        
        while let unwrapped = child {
            let wrapped: Node?
            switch cmark_node_get_type(unwrapped) {
            case CMARK_NODE_DOCUMENT:       wrapped = Document(cmarkNode: unwrapped)
            case CMARK_NODE_BLOCK_QUOTE:    wrapped = BlockQuote(cmarkNode: unwrapped)
            case CMARK_NODE_LIST:           wrapped = List(cmarkNode: unwrapped)
            case CMARK_NODE_ITEM:           wrapped = Item(cmarkNode: unwrapped)
            case CMARK_NODE_CODE_BLOCK:     wrapped = CodeBlock(cmarkNode: unwrapped)
            case CMARK_NODE_HTML_BLOCK:     wrapped = HtmlBlock(cmarkNode: unwrapped)
            case CMARK_NODE_CUSTOM_BLOCK:   wrapped = CustomBlock(cmarkNode: unwrapped)
            case CMARK_NODE_PARAGRAPH:      wrapped = Paragraph(cmarkNode: unwrapped)
            case CMARK_NODE_HEADING:        wrapped = Heading(cmarkNode: unwrapped)
            case CMARK_NODE_THEMATIC_BREAK: wrapped = ThematicBreak(cmarkNode: unwrapped)
            case CMARK_NODE_TEXT:           wrapped = Text(cmarkNode: unwrapped)
            case CMARK_NODE_SOFTBREAK:      wrapped = SoftBreak(cmarkNode: unwrapped)
            case CMARK_NODE_LINEBREAK:      wrapped = LineBreak(cmarkNode: unwrapped)
            case CMARK_NODE_CODE:           wrapped = Code(cmarkNode: unwrapped)
            case CMARK_NODE_HTML_INLINE:    wrapped = HtmlInline(cmarkNode: unwrapped)
            case CMARK_NODE_CUSTOM_INLINE:  wrapped = CustomInline(cmarkNode: unwrapped)
            case CMARK_NODE_EMPH:           wrapped = Emphasis(cmarkNode: unwrapped)
            case CMARK_NODE_STRONG:         wrapped = Strong(cmarkNode: unwrapped)
            case CMARK_NODE_LINK:           wrapped = Link(cmarkNode: unwrapped)
            case CMARK_NODE_IMAGE:          wrapped = Image(cmarkNode: unwrapped)
            default:                        wrapped = nil
            }
            
            // TODO: handle this.
            guard let node = wrapped else { fatalError() }
            result.append(node)
            child = cmark_node_next(child)
        }
        
        return result
    }
}
