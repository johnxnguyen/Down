//
//  DownGroffRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016-2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownGroffRenderable: DownRenderable {
    func toGroff(_ options: DownOptions, width: Int32) throws -> String
}

extension DownGroffRenderable {
    /// Generates a groff man string from the `markdownString` property
    ///
    /// - Parameters:
    ///   - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    ///   - width: The width to break on, defaulting to 0
    /// - Returns: groff man string
    /// - Throws: `DownErrors` depending on the scenario
    public func toGroff(_ options: DownOptions = .default, width: Int32 = 0) throws -> String {
        let ast = try DownASTRenderer.stringToAST(markdownString, options: options)
        let groff = try DownGroffRenderer.astToGroff(ast, options: options, width: width)
        cmark_node_free(ast)
        return groff
    }
}

public struct DownGroffRenderer {
    /// Generates a groff man string from the given abstract syntax tree
    ///
    /// **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns
    ///
    /// - Parameters:
    ///   - ast: The `cmark_node` representing the abstract syntax tree
    ///   - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    ///   - width: The width to break on, defaulting to 0
    /// - Returns: groff man string
    /// - Throws: `ASTRenderingError` if the AST could not be converted
    public static func astToGroff(_ ast: UnsafeMutablePointer<cmark_node>,
                                  options: DownOptions = .default,
                                  width: Int32 = 0) throws -> String {
        guard let cGroffString = cmark_render_man(ast, options.rawValue, width) else {
            throw DownErrors.astRenderingError
        }
        defer { free(cGroffString) }
        
        guard let groffString = String(cString: cGroffString, encoding: String.Encoding.utf8) else {
            throw DownErrors.astRenderingError
        }

        return groffString
    }
}
