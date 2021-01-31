//
//  Strong.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Strong: BaseNode {}

// MARK: - Debug

extension Strong: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Strong"
    }
}
