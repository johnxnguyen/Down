//
//  ParagraphStyler.swift
//  Down
//
//  Created by John Nguyen on 25.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import UIKit // TODO: conditional compilation

public struct ListItemParagraphStyler {

    let options: ListItemOptions

    private let largestPrefixWidth: CGFloat

    public init(options: ListItemOptions, largestPrefixWidth: CGFloat) {
        self.options = options
        self.largestPrefixWidth = largestPrefixWidth
    }

    private var baseStyle: NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.paragraphSpacingBefore = options.spacingAbove
        style.paragraphSpacing = options.spacingBelow
        return style
    }

    func leadingParagraphStyle(nestDepth: Int, prefixWidth: CGFloat) -> NSParagraphStyle {
        let indentation = self.indentation(atDepth: nestDepth)
        let style = baseStyle
        style.firstLineHeadIndent = indentation - options.spacingAfterPrefix - prefixWidth
        style.headIndent = indentation
        style.tabStops = [NSTextTab(textAlignment: .left, location: indentation, options: [:])]
        return style
    }

    func trailingParagraphStyle(nestDepth: Int) -> NSParagraphStyle {
        let indentation = self.indentation(atDepth: nestDepth)
        let style = baseStyle
        style.firstLineHeadIndent = indentation
        style.headIndent = indentation
        return style
    }

    private func indentation(atDepth nestDepth: Int) -> CGFloat {
        let indentationWidth: CGFloat = largestPrefixWidth + options.spacingAfterPrefix
        return indentationWidth * CGFloat(nestDepth + 1)
    }
}

public struct ListItemOptions {

    public let maxPrefixDigits: UInt
    public let spacingAfterPrefix: CGFloat
    public let spacingAbove: CGFloat
    public let spacingBelow: CGFloat

    public init(maxPrefixDigits: UInt = 2, spacingAfterPrefix: CGFloat = 8, spacingAbove: CGFloat = 4, spacingBelow: CGFloat = 8) {
        self.maxPrefixDigits = maxPrefixDigits
        self.spacingAfterPrefix = spacingAfterPrefix
        self.spacingAbove = spacingAbove
        self.spacingBelow = spacingBelow
    }
}

