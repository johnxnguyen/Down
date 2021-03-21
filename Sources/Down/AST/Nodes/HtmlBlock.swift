//
//  HtmlBlock.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class HtmlBlock: BaseNode {

    // MARK: - Properties

    /// The html content, if present.

    public private(set) lazy var literal: String? = cmarkNode.literal

}

// MARK: - Debug

extension HtmlBlock: CustomDebugStringConvertible {

    public var debugDescription: String {
        let content = (literal ?? "nil").replacingOccurrences(of: "\n", with: "\\n")
        return "Html Block - content: \(content)"
    }

}
