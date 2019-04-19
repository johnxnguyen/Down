//
//  ThematicBreak.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class ThematicBreak: Node {
    
    public var cmarkNode: CMarkNode
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_THEMATIC_BREAK`
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_THEMATIC_BREAK else { return nil }
        self.cmarkNode = cmarkNode
    }
}


// MARK: - Debug

extension ThematicBreak: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Thematic Break"
    }
}
