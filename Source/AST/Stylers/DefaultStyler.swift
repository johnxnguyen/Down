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

    public var listPrefixAttributes: [NSAttributedString.Key : Any] = [:]

    private let fonts: FontBook = DynamicFonts()

    public init() {

    }
}

// MARK: - Styling

extension DefaultStyler {

    open func style(document str: NSMutableAttributedString) {

    }

    open func style(blockQuote str: NSMutableAttributedString) {

    }

    open func style(list str: NSMutableAttributedString, nestDepth: Int) {
        // Apply paragraph styles. Indent these styles depending on the list depth.
    }

    open func style(item str: NSMutableAttributedString) {

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
