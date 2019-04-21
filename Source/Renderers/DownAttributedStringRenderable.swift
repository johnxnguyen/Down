//
//  DownAttributedStringRenderable.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownAttributedStringRenderable: DownHTMLRenderable, DownASTRenderable {
    /**
     Generates an `NSAttributedString` from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering

     - parameter stylesheet: a `String` to use as a CSS stylesheet when rendering

     - throws: `DownErrors` depending on the scenario

     - returns: An `NSAttributedString`
     */
    func toAttributedString(_ options: DownOptions, stylesheet: String?) throws -> NSAttributedString
    
    /**
     Generates an `NSAttributedString` from the `markdownString` property
     
     - parameter options: `DownOptions` to modify parsing or rendering
     
     - parameter styler: a `Styler` to use when rendering
     
     - throws: `DownErrors` depending on the scenario
     
     - returns: An `NSAttributedString`
     */
    func toAttributedString(_ options: DownOptions, styler: Styler) throws -> NSAttributedString
}

extension DownAttributedStringRenderable {
    /**
     Generates an `NSAttributedString` from the `markdownString` property
     
     The attributed string is constructed and rendered via WebKit from html generated from the
     abstract syntax tree. This process is not background safe and must be executed on the main
     thread. Additionally, it may be slow to render. For an efficient background safe render,
     use the `toAttributedString(options: styler:)` method.

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.default`

     - parameter stylesheet: a `String` to use as the CSS stylesheet when rendering, defaulting
                             to a style that uses the `NSAttributedString` default font

     - throws: `DownErrors` depending on the scenario

     - returns: An `NSAttributedString`
     */
    public func toAttributedString(_ options: DownOptions = .default, stylesheet: String? = nil) throws -> NSAttributedString {
        let html = try self.toHTML(options)
        let defaultStylesheet = "* {font-family: Helvetica } code, pre { font-family: Menlo }"
        return try NSAttributedString(htmlString: "<style>" + (stylesheet ?? defaultStylesheet) + "</style>" + html)
    }
    
    /**
     Generates an `NSAttributedString` from the `markdownString` property
     
     The attributed string is constructed directly by traversing the abstract syntax tree. It is
     much faster than the `toAttributedString(options: stylesheet)` method and it can be also be
     rendered in a background thread.
     
     - parameter options: `DownOptions` to modify parsing or rendering
     
     - parameter styler: a `Styler` to use when rendering
     
     - throws: `DownErrors` depending on the scenario
     
     - returns: An `NSAttributedString`
     */
    public func toAttributedString(_ options: DownOptions = .default, styler: Styler) throws -> NSAttributedString {
        let tree = try self.toAST(options)
        
        guard tree.type == CMARK_NODE_DOCUMENT else {
            throw DownErrors.astRenderingError
        }
        
        let document = Document(cmarkNode: tree)
        let visitor = AttributedStringVisitor(styler: styler, options: options)
        return document.accept(visitor)
    }
}
