//
//  Item.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Item: BaseNode {

    lazy var containsList: Bool = {
        return children.contains { child in
            child is List
        }
    }()
}

// MARK: - Debug

extension Item: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Item"
    }
}
