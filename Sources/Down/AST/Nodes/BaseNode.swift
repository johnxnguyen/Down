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

    // MARK: - Properties

    public let cmarkNode: CMarkNode

    public private(set) lazy var children: [Node] = Array(childSequence)

    public private(set) lazy var nestDepth: Int = {
        var depth = 0
        var next = cmarkNode.parent

        while let current = next {
            depth += current.type == cmarkNode.type ? 1 : 0
            next = current.parent
        }
        return depth
    }()

    // MARK: - Life cycle

    init(cmarkNode: CMarkNode) {
        self.cmarkNode = cmarkNode
    }

}
