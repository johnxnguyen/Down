//
//  DownHTMLRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation
import libcmark

public protocol DownHTMLRenderable: DownRenderable {
    func toHTML(_ options: DownOptions) throws -> String
}

extension DownHTMLRenderable {
    /// Generates an HTML string from the `markdownString` property
    ///
    /// - Parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    /// - Returns: HTML string
    /// - Throws: `DownErrors` depending on the scenario
    public func toHTML(_ options: DownOptions = .default) throws -> String {
        return try markdownString.toHTML(options)
    }
}

public struct DownHTMLRenderer {
    /// Generates an HTML string from the given abstract syntax tree
    ///
    /// **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns
    ///
    /// - Parameters:
    ///   - ast: The `cmark_node` representing the abstract syntax tree
    ///   - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    /// - Returns: HTML string
    /// - Throws: `ASTRenderingError` if the AST could not be converted
    public static func astToHTML(_ ast: UnsafeMutablePointer<cmark_node>, options: DownOptions = .default) throws -> String {
        guard let cHTMLString = cmark_render_html(ast, options.rawValue) else {
            throw DownErrors.astRenderingError
        }
        defer { free(cHTMLString) }
        
        guard let htmlString = String(cString: cHTMLString, encoding: String.Encoding.utf8) else {
            throw DownErrors.astRenderingError
        }

        return htmlString
    }
}
