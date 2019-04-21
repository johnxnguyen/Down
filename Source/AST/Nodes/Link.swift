//
//  Link.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Link: Node {
    
    public let cmarkNode: CMarkNode
    
    /// The title of the link, if present.
    ///
    /// In the example below, the first line is a reference link, with the reference at the
    /// bottom. `<text>` is literal text belonging to children nodes. The title occurs
    /// after the url and is optional.
    ///
    /// ```
    /// [<text>][<id>]
    /// ...
    /// [<id>]: <url> "<title>"
    /// ```
    ///
    public private(set) lazy var title: String? = cmarkNode.title
    
    /// The url of the link, if present.
    ///
    /// For example:
    ///
    /// ```
    /// [<text>](<url>)
    /// ```
    ///
    public private(set) lazy var url: String? = cmarkNode.url
    
    /// Attempts to wrap the given `CMarkNode`.
    ///
    /// This will fail if `cmark_node_get_type(cmarkNode) != CMARK_NODE_LINK`
    ///
    /// - parameter cmarkNode: the node to wrap.
    ///
    public init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_LINK else { return nil }
        self.cmarkNode = cmarkNode
    }
}


// MARK: - Debug

extension Link: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Link - title: \(title ?? "nil"), url: \(url ?? "nil"))"
    }
}
