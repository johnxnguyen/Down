//
//  Heading.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Heading: Node {
    
    public let cmarkNode: CMarkNode
        
    /// The level of the heading, a value between 1 and 6.
    public private(set) lazy var headingLevel: Int = cmarkNode.headingLevel
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_HEADING`
    ///
    /// - parameter cmarkNode: the node to wrap.
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_HEADING else { return nil }
        self.cmarkNode = cmarkNode
    }
}


// MARK: - Debug

extension Heading: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Heading - L\(headingLevel)"
    }
}
