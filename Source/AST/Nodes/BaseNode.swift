//
//  BaseNode.swift
//  Down
//
//  Created by John Nguyen on 21.04.19.
//
//

import Foundation
import libcmark

public class BaseNode: Node {
    
    public let cmarkNode: CMarkNode
    
    public private(set) lazy var children: [Node] = {
        var result: [Node] = []
        var child = cmark_node_first_child(cmarkNode)
        
        while let raw = child {
            
            guard let node = raw.wrap() else {
                assertionFailure("Couldn't wrap node of type: \(raw.type)")
                continue
            }
            
            result.append(node)
            child = cmark_node_next(child)
        }
        
        return result
    }()

    public private(set) lazy var nestDepth: Int = {
        var depth = 0
        var next = cmarkNode.parent

        while let current = next {
            depth += current.type == cmarkNode.type ? 1 : 0
            next = current.parent
        }
        return depth
    }()
    
    init(cmarkNode: CMarkNode) {
        self.cmarkNode = cmarkNode
    }
    
}
