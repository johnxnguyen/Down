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
    
    public var debugDescription: String { return "Html Inline" }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_HTML_INLINE else { return nil }
        self.cmarkNode = cmarkNode
    }
}