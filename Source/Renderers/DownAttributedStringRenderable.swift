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

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.default`

     - parameter stylesheet: a `String` to use as the CSS stylesheet when rendering, defaulting to a style that uses the `NSAttributedString` default font

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
     
     - parameter options: `DownOptions` to modify parsing or rendering
     
     - parameter styler: a `Styler` to use when rendering
     
     - throws: `DownErrors` depending on the scenario
     
     - returns: An `NSAttributedString`
     */
    
    public func toAttributedString(_ options: DownOptions = .default, styler: Styler) throws -> NSAttributedString {
        let tree = try self.toAST(options)
        guard let document = Document(cmarkNode: tree) else { throw DownErrors.astRenderingError }
        let visitor = AttributedStringVisitor(styler: styler, options: options)
        return document.accept(visitor)
    }
}
