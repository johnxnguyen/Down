//
//  Link.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Link: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String {
        return "Link - title: \(title ?? "None"), url: \(url ?? "None")"
    }
    
    var title: String? {
        guard let cString = cmark_node_get_title(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    var url: String? {
        // TODO: check if we can make this non optional
        guard let cString = cmark_node_get_url(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_LINK else { return nil }
        self.cmarkNode = cmarkNode
    }
}

