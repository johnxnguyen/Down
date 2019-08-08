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

    public var fonts: FontCollection = .dynamicFonts
    public var colors: ColorCollection = .init()
    public var paragraphStyles: ParagraphStyleCollection = .init()
    public var quoteStripeOptions: QuoteStripeOptions
    public var thematicBreakOptions: ThematicBreakOptions

    private var listPrefixAttributes: [NSAttributedString.Key : Any] {[
        .font: fonts.listItemPrefix,
        .foregroundColor: colors.listItemPrefix]
    }

    let itemParagraphStyler: ListItemParagraphStyler

    public init(listItemOptions: ListItemOptions, quoteStripeOptions: QuoteStripeOptions, thematicBreakOptions: ThematicBreakOptions) {
        // TODO: Can we not assume there is a period?
        let widthOfPeriod = NSAttributedString(string: ".", attributes: [.font: fonts.listItemPrefix]).size().width
        let maxPrefixWidth = fonts.listItemPrefix.widthOfLargestDigit * CGFloat(listItemOptions.maxPrefixDigits)
        let maxPrefixWidthIncludingPeriod = maxPrefixWidth + widthOfPeriod

        itemParagraphStyler = ListItemParagraphStyler(options: listItemOptions, largestPrefixWidth: maxPrefixWidthIncludingPeriod)

        self.quoteStripeOptions = quoteStripeOptions
        self.thematicBreakOptions = thematicBreakOptions
    }
}

// MARK: - Styling

extension DefaultStyler {

    open func style(document str: NSMutableAttributedString) {

    }

    open func style(blockQuote str: NSMutableAttributedString, nestDepth: Int) {
        let stripeAttribute = QuoteStripeAttribute(level: nestDepth + 1, options: quoteStripeOptions)

        str.updateExistingAttributes(for: .paragraphStyle) { (style: NSParagraphStyle) in
            style.indented(by: stripeAttribute.layoutWidth)
        }

        str.addAttributeInMissingRanges(for: .quoteStripe, value: stripeAttribute)
        str.addAttribute(for: .foregroundColor, value: colors.quote)
    }

    open func style(list str: NSMutableAttributedString, nestDepth: Int) {

    }

    open func style(listItemPrefix str: NSMutableAttributedString) {
        str.setAttributes(listPrefixAttributes)
    }

    open func style(item str: NSMutableAttributedString, prefixLength: Int) {
        let paragraphRanges = str.paragraphRanges()
        guard let leadingParagraphRange = paragraphRanges.first else { return }

        indentListItemLeadingParagraph(in: str, prefixLength: prefixLength, inRange: leadingParagraphRange)

        paragraphRanges.dropFirst().forEach {
            indentListItemTrailingParagraph(in: str, inRange: $0)
        }
    }

    private func indentListItemLeadingParagraph(in str: NSMutableAttributedString, prefixLength: Int, inRange range: NSRange) {
        str.updateExistingAttributes(for: .paragraphStyle, in: range) { (existingStyle: NSParagraphStyle) in
            existingStyle.indented(by: itemParagraphStyler.indentation)
        }

        let attributedPrefix = str.prefix(with: prefixLength)
        let prefixWidth = attributedPrefix.size().width

        let defaultStyle = itemParagraphStyler.leadingParagraphStyle(prefixWidth: prefixWidth)
        str.addAttributeInMissingRanges(for: .paragraphStyle, value: defaultStyle, within: range)
    }

    private func indentListItemTrailingParagraph(in str: NSMutableAttributedString, inRange range: NSRange) {
        str.updateExistingAttributes(for: .paragraphStyle, in: range) { (existingStyle: NSParagraphStyle) in
            existingStyle.indented(by: itemParagraphStyler.indentation)
        }

        let defaultStyle = itemParagraphStyler.trailingParagraphStyle
        str.addAttributeInMissingRanges(for: .paragraphStyle, value: defaultStyle, within: range)

        indentListItemQuotes(in: str, inRange: range)
    }

    private func indentListItemQuotes(in str: NSMutableAttributedString, inRange range: NSRange) {
        str.updateExistingAttributes(for: .quoteStripe, in: range) { (stripe: QuoteStripeAttribute) in
            stripe.indented(by: itemParagraphStyler.indentation)
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


    open func style(paragraph str: NSMutableAttributedString) {
        str.addAttribute(for: .paragraphStyle, value: paragraphStyles.body)
    }

    open func style(heading str: NSMutableAttributedString, level: Int) {
        let font = fonts.attributeFor(headingLevel: level) ?? fonts.heading1

        str.updateExistingAttributes(for: .font) { (currentFont: UIFont) in
            var newFont = font

            if (currentFont.isMonospace) {
                newFont = newFont.monospace
            }
            
            if (currentFont.isItalic) {
                newFont = newFont.italic
            }

            if (currentFont.isBold) {
                newFont = newFont.bold
            }

            return newFont
        }

        let color = colors.attributeFor(headingLevel: level) ?? colors.heading1
        let paragraphStyle = paragraphStyles.attributeFor(headingLevel: level) ?? paragraphStyles.heading1

        str.addAttributes([
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle])
    }

    open func style(thematicBreak str: NSMutableAttributedString) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = thematicBreakOptions.indentation
        str.addAttribute(for: .thematicBreak, value: ThematicBreakAttribute(thickness: thematicBreakOptions.thickness, color: colors.thematicBreak))
        str.addAttribute(for: .paragraphStyle, value: paragraphStyle)
    }

    open func style(text str: NSMutableAttributedString) {
        str.setAttributes([
            .font: fonts.body,
            .foregroundColor: colors.body])
    }

    open func style(softBreak str: NSMutableAttributedString) {

    }

    open func style(lineBreak str: NSMutableAttributedString) {

    }

    open func style(code str: NSMutableAttributedString) {
        str.setAttributes([
            .font: fonts.code,
            .foregroundColor: colors.code])
    }

    open func style(htmlInline str: NSMutableAttributedString) {
        str.setAttributes([
            .font: fonts.code,
            .foregroundColor: colors.code])
    }

    open func style(customInline str: NSMutableAttributedString) {
        // Not supported.
    }

    open func style(emphasis str: NSMutableAttributedString) {
        str.updateExistingAttributes(for: .font) { (font: UIFont) in
            font.italic
        }
    }

    open func style(strong str: NSMutableAttributedString) {
        str.updateExistingAttributes(for: .font) { (font: UIFont) in
            font.bold
        }
    }

    open func style(link str: NSMutableAttributedString, title: String?, url: String?) {
        guard let url = url else { return }

        str.addAttributes([
            .link: url,
            .foregroundColor: colors.link])
    }

    open func style(image str: NSMutableAttributedString, title: String?, url: String?) {
        guard let url = url else { return }

        str.addAttributes([
            .link: url,
            .foregroundColor: colors.link])
    }
}

// MARK: - Helper Extensions

private extension UIFont {

    var widthOfLargestDigit: CGFloat {
        (0...9)
            .map { NSAttributedString(string: "\($0)", attributes: [.font: self]).size().width }
            .max()!
    }
}

private extension NSParagraphStyle {

    // TODO: test
    func indented(by indentation: CGFloat) -> NSParagraphStyle {
        let result = mutableCopy() as! NSMutableParagraphStyle
        result.firstLineHeadIndent += indentation
        result.headIndent += indentation

        result.tabStops = tabStops.map {
            NSTextTab(textAlignment: $0.alignment, location: $0.location + indentation, options: $0.options)
        }

        return result
    }
}

#endif
