//
//  HtmlBlock.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class HtmlBlock: Node {
    
    public let cmarkNode: CMarkNode
    
    /// The html content, if present.
    public private(set) lazy var literal: String? = cmarkNode.literal
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_HTML_BLOCK`
    ///
    /// - parameter cmarkNode: the node to wrap.
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_HTML_BLOCK else { return nil }
        self.cmarkNode = cmarkNode
    }
}


// MARK: - Debug

extension HtmlBlock: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Html Block - \(literal ?? "nil")"
    }
}
