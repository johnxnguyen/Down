//
//  DownHTMLRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownHTMLRenderable: DownRenderable {
    /**
     Generates an HTML string from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering

     - throws: `DownErrors` depending on the scenario

     - returns: HTML string
     */
    @warn_unused_result
    func toHTML(options: DownOptions) throws -> String
}

public extension DownHTMLRenderable {
    /**
     Generates an HTML string from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `DownErrors` depending on the scenario

     - returns: HTML string
     */
    @warn_unused_result
    public func toHTML(options: DownOptions = .Default) throws -> String {
        return try markdownString.toHTML(options)
    }
}

public struct DownHTMLRenderer {
    /**
     Generates an HTML string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: HTML string
     */
    @warn_unused_result
    public static func astToHTML(ast: UnsafeMutablePointer<cmark_node>, options: DownOptions = .Default) throws -> String {
        let cHTMLString = cmark_render_html(ast, options.rawValue)
        let outputString = String(CString: cHTMLString, encoding: NSUTF8StringEncoding)

        free(cHTMLString)

        guard let htmlString = outputString else {
            throw DownErrors.ASTRenderingError
        }
        return htmlString
    }
}