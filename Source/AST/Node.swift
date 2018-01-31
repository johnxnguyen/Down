////
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

// Inspired by: https://github.com/chriseidhof/commonmark-swift

import Foundation
import libcmark

/// A simple native wrapper for a `cmark` node.
///
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
    
    /// The HTML representation at this node.
    var html: String {
        return String(cString: cmark_render_html(node, 0))
    }
    
    /// The XML representation at this node.
    var xml: String {
        return String(cString: cmark_render_xml(node, 0))
    }
    
    /// The CommonMark representation at this node.
    var commonMark: String {
        return String(cString: cmark_render_commonmark(node, CMARK_OPT_DEFAULT, 80))
    }
    
    /// The LaTeX representation at this node.
    var latex: String {
        return String(cString: cmark_render_latex(node, CMARK_OPT_DEFAULT, 80))
    }
    
    /// The tree description at this node.
    var description: String {
        return "\(typeString) {\n \(literal ?? String())\(Array(children).description) \n}"
    }
}
