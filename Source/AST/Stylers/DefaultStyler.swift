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

        str.updateAttribute(.paragraphStyle) { (style: NSParagraphStyle) in
            style.indented(by: stripeAttribute.layoutWidth)
        }

        str.addAttributeInMissingRanges(key: .quoteStripe, value: stripeAttribute)
        str.addAttribute(.foregroundColor, value: colors.quote)
    }

    open func style(list str: NSMutableAttributedString, nestDepth: Int) {

    }

    open func style(listItemPrefix str: NSMutableAttributedString) {
        str.setAttributes(listPrefixAttributes)
    }

    open func style(item str: NSMutableAttributedString, prefixLength: Int, nestDepth: Int) {

        // For simplicity, let's assume that there is no nested list directly after the prefix.
        // TODO: handle this case.

        let paragraphRanges = str.paragraphRanges()
        guard let leadingParagraphRange = paragraphRanges.first else { return }

        indentListItemLeadingParagraph(in: str, prefixLength: prefixLength, inRange: leadingParagraphRange)

        paragraphRanges.dropFirst().forEach {
            indentListItemTrailingParagraph(in: str, inRange: $0)
        }
    }

    private func indentListItemLeadingParagraph(in str: NSMutableAttributedString, prefixLength: Int, inRange range: NSRange) {
        str.updateAttribute(.paragraphStyle, inRange: range) { (existingStyle: NSParagraphStyle) in
            existingStyle.indented(by: itemParagraphStyler.indentation)
        }

        let attributedPrefix = str.prefix(with: prefixLength)
        let prefixWidth = attributedPrefix.size().width

        let defaultStyle = itemParagraphStyler.leadingParagraphStyle(prefixWidth: prefixWidth)
        str.addAttributeInMissingRanges(key: .paragraphStyle, value: defaultStyle, withinRange: range)
    }

    private func indentListItemTrailingParagraph(in str: NSMutableAttributedString, inRange range: NSRange) {
        str.updateAttribute(.paragraphStyle, inRange: range) { (existingStyle: NSParagraphStyle) in
            existingStyle.indented(by: itemParagraphStyler.indentation)
        }

        let defaultStyle = itemParagraphStyler.trailingParagraphStyle
        str.addAttributeInMissingRanges(key: .paragraphStyle, value: defaultStyle, withinRange: range)

        indentListItemQuotes(in: str, inRange: range)
    }

    private func indentListItemQuotes(in str: NSMutableAttributedString, inRange range: NSRange) {
        str.ranges(of: .quoteStripe, inRange: range).forEach { quoteRange in
            str.updateAttribute(.quoteStripe, inRange: quoteRange) { (stripe: QuoteStripeAttribute) in
                stripe.indented(by: itemParagraphStyler.indentation)
            }

            let stripe = str.attribute(.quoteStripe, at: quoteRange.lowerBound, effectiveRange: nil) as? QuoteStripeAttribute
            let stripeLayoutWidth = stripe?.layoutWidth ?? 0

            str.updateAttribute(.paragraphStyle, inRange: quoteRange) { (style: NSParagraphStyle) in
                return style.indented(by: stripeLayoutWidth)
            }
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
        str.addAttribute(.paragraphStyle, value: paragraphStyles.body)
    }

    open func style(heading str: NSMutableAttributedString, level: Int) {
        let font = fonts.attributeFor(headingLevel: level) ?? fonts.heading1

        str.updateAttribute(.font) { (currentFont: UIFont) in
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
        str.addAttribute(.thematicBreak, value: ThematicBreakAttribute(thickness: thematicBreakOptions.thickness, color: colors.thematicBreak))
        str.addAttribute(.paragraphStyle, value: paragraphStyle)
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
