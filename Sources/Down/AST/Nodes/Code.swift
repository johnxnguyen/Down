//
//  Code.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Code: BaseNode {

    // MARK: - Properties

    /// The code content, if present.

    public private(set) lazy var literal: String? = cmarkNode.literal

}

// MARK: - Debug

extension Code: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "Code - \(literal ?? "nil")"
    }

}
