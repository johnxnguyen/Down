//
//  HtmlInline.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class HtmlInline: BaseNode {
    
    /// The html tag, if present.
    public private(set) lazy var literal: String? = cmarkNode.literal
    
}

// MARK: - Debug

extension HtmlInline: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Html Inline - \(literal ?? "nil")"
    }
}
