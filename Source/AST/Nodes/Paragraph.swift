//
//  Paragraph.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Paragraph: BaseNode {

    public lazy var isTopLevel: Bool = {
        cmarkNode.parent?.type == CMARK_NODE_DOCUMENT
    }()
}

// MARK: - Debug

extension Paragraph: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Paragraph"
    }
}
