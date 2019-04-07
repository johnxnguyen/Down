//
//  Node.swift
//  Down
//
//  Created by John Nguyen on 07.04.19.
//
//  Inspired by: https://github.com/chriseidhof/commonmark-swift

import Foundation
import libcmark

class Node : CustomStringConvertible {
    
    typealias CMarkNode = UnsafeMutablePointer<cmark_node>
    
    let node: CMarkNode
    
    init(node: CMarkNode) {
        self.node = node
    }
    
    deinit {
        guard isRoot else { return }
        cmark_node_free(node)
    }
    
    var isRoot: Bool {
        return type == CMARK_NODE_DOCUMENT
    }
    
    var type: cmark_node_type {
        return cmark_node_get_type(node)
    }
    
    var listType: cmark_list_type {
        return cmark_node_get_list_type(node)
    }
    
    var listStart: Int {
        return Int(cmark_node_get_list_start(node))
    }
    
    var typeString: String {
        return String(cString: cmark_node_get_type_string(node)!)
    }
    
    var literal: String? {
        guard let cString = cmark_node_get_literal(node) else { return nil }
        return String(cString: cString)
    }
    
    var headerLevel: Int {
        return Int(cmark_node_get_heading_level(node))
    }
    
    var fenceInfo: String? {
        guard let cString = cmark_node_get_fence_info(node) else { return nil }
        return String(cString: cString)
    }
    
    var urlString: String? {
        guard let cString = cmark_node_get_url(node) else { return nil }
        return String(cString: cString)
    }
    
    var title: String? {
        guard let cString = cmark_node_get_title(node) else { return nil }
        return String(cString: cString)
    }
    
    var children: [Node] {
        var result: [Node] = []
        
        var child = cmark_node_first_child(node)
        while let unwrapped = child {
            result.append(Node(node: unwrapped))
            child = cmark_node_next(child)
        }
        return result
    }
    
    /// The tree description at this node.
    var description: String {
        return "\(typeString) {\n \(literal ?? String())\(Array(children).description) \n}"
    }
}
