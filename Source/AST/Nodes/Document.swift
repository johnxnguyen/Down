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
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_DOCUMENT else { return nil }
        self.cmarkNode = cmarkNode
    }
    
    // TODO: confirm this will release all children.
    deinit { cmark_node_free(cmarkNode) }
    
    public func accept<T: Visitor>(visitor: T) -> T.Result {
        return visitor.visit(document: self)
    }
}
