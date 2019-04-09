//
//  Paragraph.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Paragraph: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "Paragraph" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_PARAGRAPH else { return nil }
        self.cmarkNode = cmarkNode
    }
}
