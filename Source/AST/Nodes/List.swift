//
//  List.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class List: Node {
    
    enum ListType: CustomDebugStringConvertible {
        case bullet, ordered
        
        public var debugDescription: String {
            switch self {
            case .bullet: return "Bullet"
            case .ordered: return "Ordered"
            }
        }
        
        init?(type: cmark_list_type) {
            switch type {
            case CMARK_BULLET_LIST: self = .bullet
            case CMARK_ORDERED_LIST: self = .ordered
            default: return nil
            }
        }
    }
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String { return "\(listType) List - start: \(listStart)" }
    
    var listType: ListType {
        // TODO: handle
        guard let type = ListType(type: cmark_node_get_list_type(cmarkNode)) else { fatalError() }
        return type
    }
    
    var listStart: Int {
        return Int(cmark_node_get_list_start(cmarkNode))
    }
    
    lazy var numberOfItems: Int = {
        return childen.count
    }()
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_LIST else { return nil }
        self.cmarkNode = cmarkNode
    }
}
