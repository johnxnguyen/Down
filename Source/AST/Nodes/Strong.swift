//
//  Strong.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Strong: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Strong" }
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_STRONG`
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_STRONG else { return nil }
        self.cmarkNode = cmarkNode
    }
}
