//
//  DownXMLRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownXMLRenderable: DownRenderable {
    /**
     Generates an XML string from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering

     - throws: `DownErrors` depending on the scenario

     - returns: XML string
     */
    @warn_unused_result
    func toXML(options: DownOptions) throws -> String
}

public extension DownXMLRenderable {
    /**
     Generates an XML string from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `DownErrors` depending on the scenario

     - returns: XML string
     */
    @warn_unused_result
    public func toXML(options: DownOptions = .Default) throws -> String {
        let ast = try DownASTRenderer.stringToAST(markdownString, options: options)
        let xml = try DownXMLRenderer.astToXML(ast, options: options)
        cmark_node_free(ast)
        return xml
    }
}

public struct DownXMLRenderer {
    /**
     Generates an XML string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: XML string
     */
    @warn_unused_result
    public static func astToXML(ast: UnsafeMutablePointer<cmark_node>, options: DownOptions = .Default) throws -> String {
        let cXMLString = cmark_render_xml(ast, options.rawValue)
        let outputString = String(CString: cXMLString, encoding: NSUTF8StringEncoding)

        free(cXMLString)

        guard let xmlString = outputString else {
            throw DownErrors.ASTRenderingError
        }
        return xmlString
    }
}