//
//  CodeBlock.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class CodeBlock: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Code Block" }
    
    var fenceInfo: String? {
        guard let cString = cmark_node_get_fence_info(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_CODE_BLOCK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

