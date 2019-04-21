//
//  DownXMLRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016-2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownXMLRenderable: DownRenderable {
    func toXML(_ options: DownOptions) throws -> String
}

extension DownXMLRenderable {
    /// Generates an XML string from the `markdownString` property
    ///
    /// - Parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    /// - Returns: XML string
    /// - Throws: `DownErrors` depending on the scenario
    public func toXML(_ options: DownOptions = .default) throws -> String {
        let ast = try DownASTRenderer.stringToAST(markdownString, options: options)
        let xml = try DownXMLRenderer.astToXML(ast, options: options)
        cmark_node_free(ast)
        return xml
    }
}

public struct DownXMLRenderer {
    /// Generates an XML string from the given abstract syntax tree
    ///
    /// **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns
    ///
    /// - Parameters:
    ///   - ast: The `cmark_node` representing the abstract syntax tree
    ///   - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    /// - Returns: XML string
    /// - Throws: `ASTRenderingError` if the AST could not be converted
    public static func astToXML(_ ast: UnsafeMutablePointer<cmark_node>, options: DownOptions = .default) throws -> String {
        guard let cXMLString = cmark_render_xml(ast, options.rawValue) else {
            throw DownErrors.astRenderingError
        }
        defer { free(cXMLString) }
        
        guard let xmlString = String(cString: cXMLString, encoding: String.Encoding.utf8) else {
            throw DownErrors.astRenderingError
        }

        return xmlString
    }
}
