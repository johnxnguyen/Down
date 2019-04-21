//
//  HtmlBlock.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class HtmlBlock: BaseNode {
    
    /// The html content, if present.
    public private(set) lazy var literal: String? = cmarkNode.literal
    
}

// MARK: - Debug

extension HtmlBlock: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Html Block - \(literal ?? "nil")"
    }
}
