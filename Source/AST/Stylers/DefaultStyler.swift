//
//  DefaultStyler.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class DefaultStyler: Styler {

    public var listPrefixAttributes: [NSAttributedString.Key : Any]

    private let fonts: FontBook = DynamicFonts()

    public init() {
        listPrefixAttributes = [
            .font: UIFont.monospacedDigitSystemFont(ofSize: fonts.body.pointSize, weight: .regular),
            .foregroundColor: UIColor.gray
        ]
    }
}

// MARK: - Styling

extension DefaultStyler {

    open func style(document str: NSMutableAttributedString) {

    }

    open func style(blockQuote str: NSMutableAttributedString) {

    }

    open func style(list str: NSMutableAttributedString, nestDepth: Int) {

    }

    open func style(item str: NSMutableAttributedString, prefixLength: Int, nestDepth: Int) {

        // Things we need to consider.
        // 1. Don't style ranges that contain lists.
        // 2. The first paragraph has a different styling than all other paragraphs
        // 3. There might be a list immediately after the perfix. If this is the case, then we
        //    expect there to already be a break after the prefix.

        let paragraphRanges = str.paragraphRangesExcludingLists()

        // For simplicity, let's assume that there is no nested list directly after the prefix.
        // TODO: handle this case.
        guard let leadingParagraphRange = paragraphRanges.first else { return }

        let attributedPrefix = str.attributedSubstring(from: NSRange(location: 0, length: prefixLength))
        let prefixWidth = attributedPrefix.size().width
        let maxPrefixWidth = NSAttributedString(string: "99.", attributes: listPrefixAttributes).size().width
        let tabWidth: CGFloat = 8
        let indentationWidth: CGFloat = maxPrefixWidth + tabWidth
        let indentation = indentationWidth * CGFloat(nestDepth + 1)

        let firstParagraphStyle = NSMutableParagraphStyle()
        firstParagraphStyle.firstLineHeadIndent = indentation - tabWidth - prefixWidth
        firstParagraphStyle.headIndent = indentation
        firstParagraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: indentation, options: [:])]

        str.addAttribute(.paragraphStyle, value: firstParagraphStyle, range: leadingParagraphRange)

        for range in paragraphRanges.dropFirst() {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = indentation
            paragraphStyle.headIndent = indentation

            str.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        }
    }

    open func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {
        str.setAttributes([.font: fonts.code])
    }

    open func style(htmlBlock str: NSMutableAttributedString) {
        str.setAttributes([.font: fonts.code])
    }

    open func style(customBlock str: NSMutableAttributedString) {
        // Not supported.
    }

    open func style(paragraph str: NSMutableAttributedString,  isTopLevel: Bool) {
        guard isTopLevel else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacingBefore = 8
        paragraphStyle.paragraphSpacing = 8
        str.addAttribute(.paragraphStyle, value: paragraphStyle)
    }

    open func style(heading str: NSMutableAttributedString, level: Int) {
        str.update(.font) { (currentFont: UIFont) in
            var newFont = fonts.heading1

            if (currentFont.isItalic) {
                newFont = newFont.italic
            }

            if (currentFont.isBold) {
                newFont = newFont.bold
            }

            return newFont
        }
    }

    open func style(thematicBreak str: NSMutableAttributedString) {

    }

    open func style(text str: NSMutableAttributedString) {
        str.setAttributes([.font: fonts.body])
    }

    open func style(softBreak str: NSMutableAttributedString) {

    }

    open func style(lineBreak str: NSMutableAttributedString) {

    }

    open func style(code str: NSMutableAttributedString) {
        str.setAttributes([.font: fonts.code])
    }

    open func style(htmlInline str: NSMutableAttributedString) {
        str.setAttributes([.font: fonts.code])
    }

    open func style(customInline str: NSMutableAttributedString) {
        // Not supported.
    }

    open func style(emphasis str: NSMutableAttributedString) {
        str.update(.font) { (font: UIFont) in
            font.italic
        }
    }

    open func style(strong str: NSMutableAttributedString) {
        str.update(.font) { (font: UIFont) in
            font.bold
        }
    }

    open func style(link str: NSMutableAttributedString, title: String?, url: String?) {
        guard let url = url else { return }
        str.addAttribute(.link, value: url)

    }

    open func style(image str: NSMutableAttributedString, title: String?, url: String?) {
        guard let url = url else { return }
        str.addAttribute(.link, value: url)
    }
}

#endif
