//
//  Image.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Image: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String {
        return "Image - title: \(title ?? "None"), url: \(url)"
    }
    
    var title: String? {
        guard let cString = cmark_node_get_title(cmarkNode) else { return nil }
        return String(cString: cString)
    }
    
    var url: String {
        // TODO: Handle this
        guard let cString = cmark_node_get_url(cmarkNode) else { fatalError() }
        return String(cString: cString)
    }
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_IMAGE else { return nil }
        self.cmarkNode = cmarkNode
    }
}
