//
//  List.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

#if os(macOS)
import Cocoa
#else
import Foundation
#endif
import libcmark

public class List: BaseNode {
    
    public enum ListType: CustomDebugStringConvertible {
        case bullet
        case ordered(start: Int)

        #if os(macOS)
        @available(OSXApplicationExtension 10.13, OSX 10.13, *)
        public var markerFormat: NSTextList.MarkerFormat {
            switch self {
            case .bullet: return .disc
            case .ordered: return .decimal
            }
        }
        #endif

        public var startIndex: Int {
            switch self {
            case .bullet: return 0
            case .ordered(start: let start): return start
            }
        }
        
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
