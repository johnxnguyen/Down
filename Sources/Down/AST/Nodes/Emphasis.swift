//
//  Emphasis.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import Down.libcmark

public class Emphasis: BaseNode {}

// MARK: - Debug

extension Emphasis: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "Emphasis"
    }

}
