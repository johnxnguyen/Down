//
//  List.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class List: BaseNode {
    
    public enum ListType: CustomDebugStringConvertible {
        case bullet
        case ordered(start: Int)
        
        public var debugDescription: String {
            switch self {
            case .bullet: return "Bullet"
            case .ordered(let start): return "Ordered (start: \(start)"
            }
        }
        
        init?(cmarkNode: CMarkNode) {
            switch cmarkNode.listType {
            case CMARK_BULLET_LIST: self = .bullet
            case CMARK_ORDERED_LIST: self = .ordered(start: cmarkNode.listStart)
            default: return nil
            }
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////
    
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
    
}


// MARK: - Debug

extension List: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "List - type: \(listType)"
    }
}
