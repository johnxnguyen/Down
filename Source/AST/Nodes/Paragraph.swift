//
//  Paragraph.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Paragraph: Node {
    
    public let cmarkNode: CMarkNode
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_PARAGRAPH`
    ///
    /// - parameter cmarkNode: the node to wrap.
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_PARAGRAPH else { return nil }
        self.cmarkNode = cmarkNode
    }
}


// MARK: - Debug

extension Paragraph: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Paragraph"
    }
}
