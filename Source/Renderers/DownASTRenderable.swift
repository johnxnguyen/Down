//
//  DownASTRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownASTRenderable: DownRenderable {
    /**
     Generates an abstract syntax tree from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering

     - throws: `MarkdownToASTError` if conversion fails

     - returns: An abstract syntax tree representation of the Markdown input
     */
    @warn_unused_result
    func toAST(options: DownOptions) throws -> UnsafeMutablePointer<cmark_node>
}

public extension DownASTRenderable {
    /**
     Generates an abstract syntax tree from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `MarkdownToASTError` if conversion fails

     - returns: An abstract syntax tree representation of the Markdown input
     */
    @warn_unused_result
    public func toAST(options: DownOptions = .Default) throws -> UnsafeMutablePointer<cmark_node> {
        return try DownASTRenderer.stringToAST(markdownString, options: options)
    }
}

public struct DownASTRenderer {
    /**
     Generates an abstract syntax tree from the given CommonMark Markdown string
     
     **Important:** It is the caller's responsibility to call `cmark_node_free(ast)` on the returned value

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `MarkdownToASTError` if conversion fails

     - returns: An abstract syntax tree representation of the Markdown input
     */
    @warn_unused_result
    public static func stringToAST(string: String, options: DownOptions = .Default) throws -> UnsafeMutablePointer<cmark_node> {
        var tree: UnsafeMutablePointer<cmark_node>?
        string.withCString {
            let stringLength = Int(strlen($0))
            tree = cmark_parse_document($0, stringLength, options.rawValue)
        }

        guard let ast = tree else {
            throw DownErrors.MarkdownToASTError
        }
        return ast
    }
}