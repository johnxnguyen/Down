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

    var options: ListItemOptions

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
        let contentIndentation = self.indentation(atDepth: nestDepth)
        let prefixIndentation: CGFloat = contentIndentation - options.spacingAfterPrefix - prefixWidth
        let prefixSpill = max(0, prefixWidth - largestPrefixWidth)
        let firstLineContentIndentation = contentIndentation + prefixSpill

        let style = baseStyle
        style.firstLineHeadIndent = prefixIndentation
        style.tabStops = [tabStop(at: firstLineContentIndentation)]
        style.headIndent = contentIndentation
        return style
    }

    func trailingParagraphStyle(nestDepth: Int) -> NSParagraphStyle {
        let contentIndentation = self.indentation(atDepth: nestDepth)
        let style = baseStyle
        style.firstLineHeadIndent = contentIndentation
        style.headIndent = contentIndentation
        return style
    }

    private func indentation(atDepth nestDepth: Int) -> CGFloat {
        let indentationWidth: CGFloat = largestPrefixWidth + options.spacingAfterPrefix
        return indentationWidth * CGFloat(nestDepth + 1)
    }

    private func tabStop(at location: CGFloat) -> NSTextTab {
        return NSTextTab(textAlignment: .left, location: location, options: [:])
    }
}

public struct ListItemOptions {

    public var maxPrefixDigits: UInt
    public var spacingAfterPrefix: CGFloat
    public var spacingAbove: CGFloat
    public var spacingBelow: CGFloat

    public init(maxPrefixDigits: UInt = 2, spacingAfterPrefix: CGFloat = 8, spacingAbove: CGFloat = 4, spacingBelow: CGFloat = 8) {
        self.maxPrefixDigits = maxPrefixDigits
        self.spacingAfterPrefix = spacingAfterPrefix
        self.spacingAbove = spacingAbove
        self.spacingBelow = spacingBelow
    }
}

