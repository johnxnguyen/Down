//
//  LineBreak.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class LineBreak: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Line Break" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_LINEBREAK else { return nil }
        self.cmarkNode = cmarkNode
    }
}
