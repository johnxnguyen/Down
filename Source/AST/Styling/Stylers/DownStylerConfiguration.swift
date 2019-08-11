//
//  DownStylerConfiguration.swift
//  Down
//
//  Created by John Nguyen on 10.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public struct DownStylerConfiguration {
    
    public var fonts = FontCollection()
    public var colors = ColorCollection()
    public var paragraphStyles = ParagraphStyleCollection()
    public var listItemOptions = ListItemOptions()
    public var quoteStripeOptions = QuoteStripeOptions()
    public var thematicBreakOptions = ThematicBreakOptions()

    public var codeBlockInset: CGFloat = 8

    public init() {}
}

#endif
