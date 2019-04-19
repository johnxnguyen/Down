//
//  Image.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import libcmark

public class Image: Node {
    
    public var cmarkNode: CMarkNode
    
    public var debugDescription: String {
        return "Image - title: \(title ?? "nil"), url: \(url ?? "nil"))"
    }
    
    /// The title of the image, if present.
    ///
    /// In the example below, the first line is a reference link, with the reference at the
    /// bottom. `<text>` is literal text belonging to children nodes. The title occurs
    /// after the url and is optional.
    ///
    /// ```
    /// ![<text>][<id>]
    /// ...
    /// [<id>]: <url> "<title>"
    /// ```
    ///
    lazy var title: String? = cmarkNode.title
    
    /// The url of the image, if present.
    ///
    /// For example:
    ///
    /// ```
    /// ![<text>](<url>)
    /// ```
    ///
    lazy var url: String? = cmarkNode.url
    
    init?(cmarkNode: CMarkNode) {
        guard cmarkNode.type == CMARK_NODE_IMAGE else { return nil }
        self.cmarkNode = cmarkNode
    }
}
