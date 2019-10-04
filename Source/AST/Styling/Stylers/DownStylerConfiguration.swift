//
//  DownStylerConfiguration.swift
//  Down
//
//  Created by John Nguyen on 10.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS)

/// A configuration object used to initialze the `DownStyler`.
public struct DownStylerConfiguration {
    
    public var fonts: FontCollection = StaticFontCollection()
    public var colors: ColorCollection = StaticColorCollection()
    public var paragraphStyles = ParagraphStyleCollection()
    
    public var listItemOptions = ListItemOptions()
    public var quoteStripeOptions = QuoteStripeOptions()
    public var thematicBreakOptions = ThematicBreakOptions()
    public var codeBlockOptions = CodeBlockOptions()

    public init() {}
}

#endif
