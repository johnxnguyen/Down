//
//  Text.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Text: Node {
    
    public var cmarkNode: CMarkNode
    
    /// The text content, if present.
    public private(set) lazy var literal: String? = cmarkNode.literal
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_TEXT`
    ///
    /// - parameter cmarkNode: the node to wrap.
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_TEXT else { return nil }
        self.cmarkNode = cmarkNode
    }
}


// MARK: - Debug

extension Text: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Text - \(literal ?? "nil")"
    }
}
