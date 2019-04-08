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


public class Document: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Document" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_DOCUMENT else { return nil }
        self.cmarkNode = cmarkNode
    }
    
    // TODO: confirm this will release all children.
    deinit { cmark_node_free(cmarkNode) }
}

public class BlockQuote: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Block Quote" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_BLOCK_QUOTE else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class List: Node {
    
    enum ListType: CustomDebugStringConvertible {
        case bullet, ordered
        
        public var debugDescription: String {
            switch self {
            case .bullet: return "Bullet"
            case .ordered: return "Ordered"
            }
        }
        
        init?(type: cmark_list_type) {
            switch type {
            case CMARK_BULLET_LIST: self = .bullet
            case CMARK_ORDERED_LIST: self = .ordered
            default: return nil
            }
        }
    }
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "\(listType) List - start: \(listStart)" }
    
    var listType: ListType {
        // TODO: handle
        guard let type = ListType(type: cmark_node_get_list_type(cmarkNode)) else { fatalError() }
        return type
    }
    
    var listStart: Int {
        return Int(cmark_node_get_list_start(cmarkNode))
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_LIST else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Item: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Item" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_ITEM else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class CodeBlock: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Code Block" }
    
    var fenceInfo: String? {
        guard let cString = cmark_node_get_fence_info(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_CODE_BLOCK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class HtmlBlock: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Html Block" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_HTML_BLOCK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class CustomBlock: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Custom Block" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_CUSTOM_BLOCK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Paragraph: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Paragraph" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_PARAGRAPH else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Heading: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Heading: L\(headerLevel)" }
    
    var headerLevel: Int {
        return Int(cmark_node_get_heading_level(cmarkNode))
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_HEADING else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class ThematicBreak: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Thematic Break" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_THEMATIC_BREAK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Text: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Text: '\(literal)'" }
    
    var literal: String {
        // TODO: is it expected that there is a literal?
        guard let cString = cmark_node_get_literal(cmarkNode) else { fatalError() }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_TEXT else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class SoftBreak: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Soft Break" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_SOFTBREAK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class LineBreak: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Line Break" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_LINEBREAK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Code: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Code: '\(literal)'" }
    
    var literal: String {
        // TODO: is it expected that there is a literal?
        guard let cString = cmark_node_get_literal(cmarkNode) else { fatalError() }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_CODE else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class HtmlInline: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Html Inline" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_HTML_INLINE else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class CustomInline: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Custom Inline" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_CUSTOM_INLINE else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Emphasis: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Emphasis" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_EMPH else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Strong: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Strong" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_STRONG else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Link: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String {
        return "Link - title: \(title ?? "None"), url: \(url ?? "None")"
    }
    
    var title: String? {
        guard let cString = cmark_node_get_title(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    var url: String? {
        // TODO: check if we can make this non optional
        guard let cString = cmark_node_get_url(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_LINK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

public class Image: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String {
        return "Image - title: \(title ?? "None"), url: \(url ?? "None")"
    }
    
    var title: String? {
        guard let cString = cmark_node_get_title(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    var url: String? {
        // TODO: check if we can make this non optional
        guard let cString = cmark_node_get_url(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_IMAGE else { return nil }
        self.cmarkNode = cmarkNode
    }
}
