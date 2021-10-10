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

    /// The list delimiter.

    public lazy var delimiter: Delimiter? = Delimiter(cmarkNode.listDelimiter)
}

// MARK: - List Type

public extension List {

    enum Delimiter {
        case period
        case paren

        init?(_ cmark: cmark_delim_type) {
            switch cmark {
            case CMARK_NO_DELIM: return nil
            case CMARK_PERIOD_DELIM: self = .period
            case CMARK_PAREN_DELIM: self = .paren
            default: preconditionFailure("Invalid delim type")
            }
        }
    }

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
        var result = "List - type: \(listType), isTight: \(isTight)"
        if let delim = delimiter {
            result += ", delimiter: \(delim)"
        }
        return result
    }

}

extension List.Delimiter: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .paren: return "paren"
        case .period: return "period"
        }
    }
}
