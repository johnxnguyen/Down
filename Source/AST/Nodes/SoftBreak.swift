//
//  SoftBreak.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class SoftBreak: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Soft Break" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_SOFTBREAK else { return nil }
        self.cmarkNode = cmarkNode
    }
}
