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

    let maxPrefix = "99."
    let maxPrefixWidth: CGFloat
    let prefixSpace: CGFloat = 8

    let spacingBefore: CGFloat = 4
    let spacingAfter: CGFloat = 8

    init(prefixAttributes: NSAttributedString.Attributes) {
        maxPrefixWidth = NSAttributedString(string: maxPrefix, attributes: prefixAttributes).size().width
    }

    func leadingParagraphStyle(nestDepth: Int, prefixWidth: CGFloat) -> NSParagraphStyle {
        let indentation = self.indentation(atDepth: nestDepth)
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = indentation - prefixSpace - prefixWidth
        style.headIndent = indentation
        style.tabStops = [NSTextTab(textAlignment: .left, location: indentation, options: [:])]
        style.paragraphSpacingBefore = spacingBefore
        style.paragraphSpacing = spacingAfter
        return style
    }

    func trailingParagraphStyle(nestDepth: Int) -> NSParagraphStyle {
        let indentation = self.indentation(atDepth: nestDepth)
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = indentation
        style.headIndent = indentation
        style.paragraphSpacingBefore = spacingBefore
        style.paragraphSpacing = spacingAfter
        return style
    }

    private func indentation(atDepth nestDepth: Int) -> CGFloat {
        let indentationWidth: CGFloat = maxPrefixWidth + prefixSpace
        return indentationWidth * CGFloat(nestDepth + 1)
    }
}
