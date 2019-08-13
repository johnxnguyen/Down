//
//  CodeBlock.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class CodeBlock: BaseNode {
    
    /// The code content, if present.
    public private(set) lazy var literal: String? = cmarkNode.literal
    
    /// The fence info is an optional string that trails the opening sequence of backticks.
    /// It can be used to provide some contextual information about the block, such as
    /// the name of a programming language.
    ///
    /// For example:
    /// ```
    /// '''<fence info>
    /// <literal>
    /// '''
    /// ```
    ///
    public private(set) lazy var fenceInfo: String? = cmarkNode.fenceInfo
    
}

// MARK: - Debug

extension CodeBlock: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        let content = (literal ?? "nil").replacingOccurrences(of: "\n", with: "\\n")
        return "Code Block - fenceInfo: \(fenceInfo ?? "nil"), content: \(content)"
    }
}
