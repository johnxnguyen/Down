//
//  DownAttributedStringRenderable.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(Linux)

import Foundation
import libcmark

public protocol DownAttributedStringRenderable: DownHTMLRenderable, DownASTRenderable {

    func toAttributedString(_ options: DownOptions, stylesheet: String?) throws -> NSAttributedString
    func toAttributedString(_ options: DownOptions, styler: Styler) throws -> NSAttributedString

}

extension DownAttributedStringRenderable {

    /// Generates an `NSAttributedString` from the `markdownString` property.
    ///
    /// **Note:** The attributed string is constructed and rendered via WebKit from html generated from the
    /// abstract syntax tree. This process is not background safe and must be executed on the main
    /// thread. Additionally, it may be slow to render. For an efficient background safe render,
    /// use the `toAttributedString(options: styler:)` method below.
    ///
    /// - Parameters:
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///     - stylesheet: a `String` to use as the CSS stylesheet when rendering, defaulting
    ///       to a style that uses the `NSAttributedString` default font.
    ///
    /// - Returns:
    ///     An `NSAttributedString`.
    /// - Throws:
    ///     `DownErrors` depending on the scenario.

    public func toAttributedString(_ options: DownOptions = .default,
                                   stylesheet: String? = nil) throws -> NSAttributedString {

        let html = try self.toHTML(options)
        let defaultStylesheet = "* {font-family: Helvetica } code, pre { font-family: Menlo }"
        return try NSAttributedString(htmlString: "<style>" + (stylesheet ?? defaultStylesheet) + "</style>" + html)
    }

    /// Generates an `NSAttributedString` from the `markdownString` property.
    ///
    /// **Note:** The attributed string is constructed directly by traversing the abstract syntax tree. It is
    /// much faster than the `toAttributedString(options: stylesheet)` method and it can be also be
    /// rendered in a background thread.
    ///
    /// - Parameters:
    ///     - options: `DownOptions` to modify parsing or rendering.
    ///     - styler: a class/struct conforming to `Styler` to use when rendering the various
    ///       elements of the attributed string
    ///
    /// - Returns:
    ///     An `NSAttributedString`.
    ///
    /// - Throws:
    ///     `DownErrors` depending on the scenario.

    public func toAttributedString(_ options: DownOptions = .default, styler: Styler) throws -> NSAttributedString {
        let document = try self.toDocument(options)
        let visitor = AttributedStringVisitor(styler: styler, options: options)
        return document.accept(visitor)
    }

}

#endif // !os(Linux)
