//
//  ThematicBreak.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class ThematicBreak: BaseNode {}

// MARK: - Debug

extension ThematicBreak: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Thematic Break"
    }
}
