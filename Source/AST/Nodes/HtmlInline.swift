//
//  HtmlInline.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class HtmlInline: Node {
    
    public var cmarkNode: CMarkNode
    
    // TODO: be more secific here.
    /// The html content, if present.
    public lazy var literal: String? = cmarkNode.literal
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_HTML_INLINE`
    ///
    /// - parameter cmarkNode: the node to wrap.
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_HTML_INLINE else { return nil }
        self.cmarkNode = cmarkNode
    }
}


// MARK: - Debug

extension HtmlInline: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Html Inline - \(literal ?? "nil")"
    }
}
