//
//  DownLaTeXRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownLaTeXRenderable: DownRenderable {
    /**
     Generates a LaTeX string from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering
     - parameter width:   The width to break on

     - throws: `DownErrors` depending on the scenario

     - returns: LaTeX string
     */
    @warn_unused_result
    func toLaTeX(options: DownOptions, width: Int32) throws -> String
}

public extension DownLaTeXRenderable {
    /**
     Generates a LaTeX string from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `DownErrors` depending on the scenario

     - returns: LaTeX string
     */
    @warn_unused_result
    public func toLaTeX(options: DownOptions = .Default, width: Int32 = 0) throws -> String {
        let ast = try DownASTRenderer.stringToAST(markdownString, options: options)
        let latex = try DownLaTeXRenderer.astToLaTeX(ast, options: options, width: width)
        cmark_node_free(ast)
        return latex
    }
}

public struct DownLaTeXRenderer {
    /**
     Generates a LaTeX string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: LaTeX string
     */
    @warn_unused_result
    public static func astToLaTeX(ast: UnsafeMutablePointer<cmark_node>,
                                  options: DownOptions = .Default,
                                  width: Int32 = 0) throws -> String {
        let cLatexString = cmark_render_latex(ast, options.rawValue, width)
        let outputString = String(CString: cLatexString, encoding: NSUTF8StringEncoding)

        free(cLatexString)

        guard let latexString = outputString else {
            throw DownErrors.ASTRenderingError
        }
        return latexString
    }
}