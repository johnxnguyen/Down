//
//  BaseNode.swift
//  Down
//
//  Created by John Nguyen on 21.04.19.
//
//

import Foundation

public class BaseNode: Node {
    
    public let cmarkNode: CMarkNode
    
    init(cmarkNode: CMarkNode) {
        self.cmarkNode = cmarkNode
    }
}
