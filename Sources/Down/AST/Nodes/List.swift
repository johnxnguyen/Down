//
//  List.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class List: BaseNode {

    // MARK: - Properties

    /// The type of the list, either bullet or ordered.

    public lazy var listType: ListType = {
        guard let type = ListType(cmarkNode: cmarkNode) else {
            assertionFailure("Unsupported or missing list type. Defaulting to .bullet.")
            return .bullet
        }

        return type
    }()

    /// The number of items in the list.

    public lazy var numberOfItems: Int = children.count

    /// Whether the list is "tight".
    ///
    /// If any of the list items are separated by a blank line, then this property is `false`. This value is
    /// a hint to render the list with more (loose) or less (tight) spacing between items.

    public lazy var isTight: Bool = cmark_node_get_list_tight(cmarkNode) == 1

}

// MARK: - List Type

public extension List {

    enum ListType: CustomDebugStringConvertible {
        case bullet
        case ordered(start: Int)

        // MARK: - Properties

        public var debugDescription: String {
            switch self {
            case .bullet: return "Bullet"
            case .ordered(let start): return "Ordered (start: \(start))"
            }
        }

        // MARK: - Life cycle

        init?(cmarkNode: CMarkNode) {
            switch cmarkNode.listType {
            case CMARK_BULLET_LIST: self = .bullet
            case CMARK_ORDERED_LIST: self = .ordered(start: cmarkNode.listStart)
            default: return nil
            }
        }

    }
}

// MARK: - Debug

extension List: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "List - type: \(listType), isTight: \(isTight)"
    }

}
