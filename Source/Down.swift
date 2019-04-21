//
//  Down.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016-2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

public struct Down: DownASTRenderable, DownHTMLRenderable, DownXMLRenderable,
                    DownLaTeXRenderable, DownGroffRenderable, DownCommonMarkRenderable,
                    DownAttributedStringRenderable {
    /// A string containing CommonMark Markdown
    public var markdownString: String

    /// Initializes the container with a CommonMark Markdown string which can then be rendered depending on protocol conformance
    ///
    /// - Parameter markdownString: A string containing CommonMark Markdown
    public init(markdownString: String) {
        self.markdownString = markdownString
    }
}
