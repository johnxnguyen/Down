//
//  DownGroffRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownGroffRenderable: DownRenderable {
    /**
     Generates a groff man string from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering
     - parameter width:   The width to break on

     - throws: `DownErrors` depending on the scenario

     - returns: groff man string
     */
    @warn_unused_result
    func toGroff(options: DownOptions, width: Int32) throws -> String
}

public extension DownGroffRenderable {
    /**
     Generates a groff man string from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `DownErrors` depending on the scenario

     - returns: groff man string
     */
    @warn_unused_result
    public func toGroff(options: DownOptions = .Default, width: Int32 = 0) throws -> String {
        let ast = try DownASTRenderer.stringToAST(markdownString, options: options)
        let groff = try DownGroffRenderer.astToGroff(ast, options: options, width: width)
        cmark_node_free(ast)
        return groff
    }
}

public struct DownGroffRenderer {
    /**
     Generates a groff man string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: groff man string
     */
    @warn_unused_result
    public static func astToGroff(ast: UnsafeMutablePointer<cmark_node>,
                                  options: DownOptions = .Default,
                                  width: Int32 = 0) throws -> String {
        let cGroffString = cmark_render_man(ast, options.rawValue, width)
        let outputString = String(CString: cGroffString, encoding: NSUTF8StringEncoding)

        free(cGroffString)

        guard let groffString = outputString else {
            throw DownErrors.ASTRenderingError
        }
        return groffString
    }
}