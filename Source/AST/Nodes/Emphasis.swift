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
    
    public var debugDescription: String { return "Emphasis" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_EMPH else { return nil }
        self.cmarkNode = cmarkNode
    }
}
