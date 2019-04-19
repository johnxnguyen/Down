//
//  Emphasis.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Emphasis: Node {
    
    public var cmarkNode: CMarkNode
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_EMPH`
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_EMPH else { return nil }
        self.cmarkNode = cmarkNode
    }
}


// MARK: - Debug

extension Emphasis: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Emphasis"
    }
}
