//
//  BlockQuote.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class BlockQuote: BaseNode {}

// MARK: - Debug

extension BlockQuote: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Block Quote"
    }
}
