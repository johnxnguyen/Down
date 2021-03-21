//
//  DownStylerConfiguration.swift
//  Down
//
//  Created by John Nguyen on 10.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS) && !os(Linux)

/// A configuration object used to initialze the `DownStyler`.

public struct DownStylerConfiguration {

    // MARK: - Properties

    public var fonts: FontCollection
    public var colors: ColorCollection
    public var paragraphStyles: ParagraphStyleCollection

    public var listItemOptions: ListItemOptions
    public var quoteStripeOptions: QuoteStripeOptions
    public var thematicBreakOptions: ThematicBreakOptions
    public var codeBlockOptions: CodeBlockOptions

    // MARK: - Life cycle

    public init(fonts: FontCollection = StaticFontCollection(),
                colors: ColorCollection = StaticColorCollection(),
                paragraphStyles: ParagraphStyleCollection = StaticParagraphStyleCollection(),
                listItemOptions: ListItemOptions = ListItemOptions(),
                quoteStripeOptions: QuoteStripeOptions = QuoteStripeOptions(),
                thematicBreakOptions: ThematicBreakOptions = ThematicBreakOptions(),
                codeBlockOptions: CodeBlockOptions = CodeBlockOptions()
    ) {
        self.fonts = fonts
        self.colors = colors
        self.paragraphStyles = paragraphStyles
        self.listItemOptions = listItemOptions
        self.quoteStripeOptions = quoteStripeOptions
        self.thematicBreakOptions = thematicBreakOptions
        self.codeBlockOptions = codeBlockOptions
    }

}

#endif
