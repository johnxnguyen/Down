//
//  DownCommonMarkRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016-2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownCommonMarkRenderable: DownRenderable {
    func toCommonMark(_ options: DownOptions, width: Int32) throws -> String
}

extension DownCommonMarkRenderable {
    /// Generates a CommonMark Markdown string from the `markdownString` property
    ///
    /// - Parameters:
    ///   - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    ///   - width: The width to break on, defaulting to 0
    /// - Returns: CommonMark Markdown string
    /// - Throws: `DownErrors` depending on the scenario
    public func toCommonMark(_ options: DownOptions = .default, width: Int32 = 0) throws -> String {
        let ast = try DownASTRenderer.stringToAST(markdownString, options: options)
        let commonMark = try DownCommonMarkRenderer.astToCommonMark(ast, options: options, width: width)
        cmark_node_free(ast)
        return commonMark
    }
}

public struct DownCommonMarkRenderer {
    /// Generates a CommonMark Markdown string from the given abstract syntax tree
    ///
    /// **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns
    ///
    /// - Parameters:
    ///   - ast: The `cmark_node` representing the abstract syntax tree
    ///   - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    ///   - width: The width to break on, defaulting to 0
    /// - Returns: CommonMark Markdown string
    /// - Throws: `ASTRenderingError` if the AST could not be converted
    public static func astToCommonMark(_ ast: UnsafeMutablePointer<cmark_node>,
                                       options: DownOptions = .default,
                                       width: Int32 = 0) throws -> String {
        guard let cCommonMarkString = cmark_render_commonmark(ast, options.rawValue, width) else {
            throw DownErrors.astRenderingError
        }
        defer { free(cCommonMarkString) }
        
        guard let commonMarkString = String(cString: cCommonMarkString, encoding: String.Encoding.utf8) else {
            throw DownErrors.astRenderingError
        }
        
        return commonMarkString
    }
}
