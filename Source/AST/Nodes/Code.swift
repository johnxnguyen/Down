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
    
    public var debugDescription: String { return "Code: '\(literal)'" }
    
    var literal: String {
        // TODO: is it expected that there is a literal?
        guard let cString = cmark_node_get_literal(cmarkNode) else { fatalError() }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_CODE else { return nil }
        self.cmarkNode = cmarkNode
    }
}
