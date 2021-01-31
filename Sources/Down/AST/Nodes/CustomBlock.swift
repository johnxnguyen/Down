//
//  CustomBlock.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class CustomBlock: BaseNode {
    
    /// The custom content, if present.
    public private(set) lazy var literal: String? = cmarkNode.literal
    
}

// MARK: - Debug

extension CustomBlock: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Custom Block - \(literal ?? "nil")"
    }
}
