//
//  DownOptions.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation

public struct DownOptions: OptionSetType {
    public let rawValue: Int32
    public init(rawValue: Int32) { self.rawValue = rawValue }

    /**
     Default options
    */
    public static let Default = DownOptions(rawValue: 0)

    // MARK: - Rendering Options

    /**
     Include a `data-sourcepos` attribute on all block elements
    */
    public static let SourcePos = DownOptions(rawValue: 1 << 1)

    /**
     Render `softbreak` elements as hard line breaks.
    */
    public static let HardBreaks = DownOptions(rawValue: 1 << 2)

    /**
     Suppress raw HTML and unsafe links (`javascript:`, `vbscript:`,
     `file:`, and `data:`, except for `image/png`, `image/gif`,
     `image/jpeg`, or `image/webp` mime types).  Raw HTML is replaced
     by a placeholder HTML comment. Unsafe links are replaced by
     empty strings.
    */
    public static let Safe = DownOptions(rawValue: 1 << 3)

    // MARK: - Parsing Options

    /**
     Normalize tree by consolidating adjacent text nodes.
    */
    public static let Normalize = DownOptions(rawValue: 1 << 4)

    /**
     Validate UTF-8 in the input before parsing, replacing illegal
     sequences with the replacement character U+FFFD.
    */
    public static let ValidateUTF8 = DownOptions(rawValue: 1 << 5)

    /**
     Convert straight quotes to curly, --- to em dashes, -- to en dashes.
    */
    public static let Smart = DownOptions(rawValue: 1 << 6)

}
