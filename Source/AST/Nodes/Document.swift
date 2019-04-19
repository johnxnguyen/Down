//
//  Document.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Document: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Document" }
    
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_DOCUMENT else { return nil }
        self.cmarkNode = cmarkNode
    }
    
    deinit {
        // Frees the node and all its children.
        cmark_node_free(cmarkNode)
    }
    
    /// Accepts the given visitor and return its result.
    public func accept<T: Visitor>(_ visitor: T) -> T.Result {
        return visitor.visit(document: self)
    }
}
