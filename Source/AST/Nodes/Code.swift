//
//  Code.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Code: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Code - \(literal ?? "nil")" }
    
    /// The code content, if present.
    lazy var literal: String? = cmarkNode.literal
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_CODE`
    ///
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_CODE else { return nil }
        self.cmarkNode = cmarkNode
    }
}
