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

    public let listPrefixAttributes: [NSAttributedString.Key : Any]

    private let fonts: FontCollection
    private let colors: ColorCollection
    private let paragraphStyles: ParagraphStyleCollection

    private let paragraphStyler: ListItemParagraphStyler

    public init(fonts: FontCollection = .dynamicFonts,
                colors: ColorCollection = .init(),
                paragraphStyles: ParagraphStyleCollection = .init()) {

        self.fonts = fonts
        self.colors = colors
        self.paragraphStyles = paragraphStyles

        listPrefixAttributes = [
            .font: UIFont.monospacedDigitSystemFont(ofSize: fonts.body.pointSize, weight: .regular),
            .foregroundColor: UIColor.gray
        ]

        paragraphStyler = ListItemParagraphStyler(prefixAttributes: listPrefixAttributes)
    }
}

// MARK: - Styling

extension DefaultStyler {

    open func style(document str: NSMutableAttributedString) {

    }

    open func style(blockQuote str: NSMutableAttributedString) {
        str.setAttributes([
            .font: fonts.quote,
            .foregroundColor: colors.quote,
            .paragraphStyle: paragraphStyles.quote])
    }

    open func style(list str: NSMutableAttributedString, nestDepth: Int) {

    }

    open func style(item str: NSMutableAttributedString, prefixLength: Int, nestDepth: Int) {
        // For simplicity, let's assume that there is no nested list directly after the prefix.
        // TODO: handle this case.

        let paragraphRanges = str.paragraphRangesExcludingLists()
        guard let leadingParagraphRange = paragraphRanges.first else { return }
        
        let attributedPrefix = str.prefix(with: prefixLength)
        let prefixWidth = attributedPrefix.size().width
        let leadingParagraphStyle = paragraphStyler.leadingParagraphStyle(nestDepth: nestDepth, prefixWidth: prefixWidth)
        str.addAttribute(.paragraphStyle, value: leadingParagraphStyle, range: leadingParagraphRange)

        for range in paragraphRanges.dropFirst() {
            let paragraphStyle = paragraphStyler.trailingParagraphStyle(nestDepth: nestDepth)
            str.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        }
    }

    open func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {
        str.setAttributes([
            .font: fonts.code,
            .foregroundColor: colors.code,
            .paragraphStyle: paragraphStyles.code])
    }

    open func style(htmlBlock str: NSMutableAttributedString) {
        str.setAttributes([
            .font: fonts.code,
            .foregroundColor: colors.code,
            .paragraphStyle: paragraphStyles.code])
    }

    open func style(customBlock str: NSMutableAttributedString) {
        // Not supported.
    }

    open func style(paragraph str: NSMutableAttributedString,  isTopLevel: Bool) {
        guard isTopLevel else { return }
        str.addAttribute(.paragraphStyle, value: paragraphStyles.body)
    }

    open func style(heading str: NSMutableAttributedString, level: Int) {
        str.updateAttribute(.font) { (currentFont: UIFont) in
            var newFont = fonts.heading1

            if (currentFont.isItalic) {
                newFont = newFont.italic
            }

            if (currentFont.isBold) {
                newFont = newFont.bold
            }

            return newFont
        }

        // TODO: Add helper to get the right style for the level
        str.addAttribute(.paragraphStyle, value: paragraphStyles.heading1)
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
        str.updateAttribute(.font) { (font: UIFont) in
            font.italic
        }
    }

    open func style(strong str: NSMutableAttributedString) {
        str.updateAttribute(.font) { (font: UIFont) in
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
