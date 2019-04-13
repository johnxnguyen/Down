//
//  Heading.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Heading: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Heading - L\(headerLevel)" }
    
    var headerLevel: Int {
        return Int(cmark_node_get_heading_level(cmarkNode))
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_HEADING else { return nil }
        self.cmarkNode = cmarkNode
    }
}
