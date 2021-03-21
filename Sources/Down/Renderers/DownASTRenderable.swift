//
//  DownASTRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation
import libcmark

public protocol DownASTRenderable: DownRenderable {

    func toAST(_ options: DownOptions) throws -> CMarkNode

}

extension DownASTRenderable {

    /// Generates an abstract syntax tree from the `markdownString` property.
    ///
    /// - Parametera:
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     An abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    /// `MarkdownToASTError` if conversion fails.

    public func toAST(_ options: DownOptions = .default) throws -> CMarkNode {
        return try DownASTRenderer.stringToAST(markdownString, options: options)
    }

    /// Parses the `markdownString` property into an abstract syntax tree and returns the root `Document` node.
    ///
    /// - Parameters:
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     The root Document node for the abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    ///     `MarkdownToASTError` if conversion fails.

    public func toDocument(_ options: DownOptions = .default) throws -> Document {
        let tree = try toAST(options)

        guard tree.type == CMARK_NODE_DOCUMENT else {
            throw DownErrors.astRenderingError
        }

        return Document(cmarkNode: tree)
    }

}

public struct DownASTRenderer {

    /// Generates an abstract syntax tree from the given CommonMark Markdown string.
    ///
    /// **Important:** It is the caller's responsibility to call `cmark_node_free(ast)` on the returned value.
    ///
    /// - Parameters:
    ///     - string: A string containing CommonMark Markdown.
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     An abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    ///     `MarkdownToASTError` if conversion fails.
    public static func stringToAST(_ string: String, options: DownOptions = .default) throws -> CMarkNode {
        var tree: CMarkNode?

        string.withCString {
            let stringLength = Int(strlen($0))
            tree = cmark_parse_document($0, stringLength, options.rawValue)
        }

        guard let ast = tree else {
            throw DownErrors.markdownToASTError
        }

        return ast
    }

}
