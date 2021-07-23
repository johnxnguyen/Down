//
//  Item.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import Down.libcmark

public class Item: BaseNode {}

// MARK: - Debug

extension Item: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "Item"
    }

}
