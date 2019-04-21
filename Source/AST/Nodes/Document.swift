//
//  Document.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Document: BaseNode {
    
    deinit {
        // Frees the node and all its children.
        cmark_node_free(cmarkNode)
    }
    
    /// Accepts the given visitor and return its result.
    public func accept<T: Visitor>(_ visitor: T) -> T.Result {
        return visitor.visit(document: self)
    }
    
}


// MARK: - Debug

extension Document: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Document"
    }
}
