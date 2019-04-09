//
//  ThematicBreak.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class ThematicBreak: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Thematic Break" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_THEMATIC_BREAK else { return nil }
        self.cmarkNode = cmarkNode
    }
}
