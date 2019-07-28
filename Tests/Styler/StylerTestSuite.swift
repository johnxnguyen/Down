//
//  StylerTestSuite.swift
//  DownTests
//
//  Created by John Nguyen on 27.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import Down

class StylerTestSuite: XCTestCase {

    // MARK: - Configurable Properties

    var sut: DefaultStyler!

    var heading1Font = UIFont.systemFont(ofSize: 28)
    var heading2Font = UIFont.systemFont(ofSize: 24)
    var heading3Font = UIFont.systemFont(ofSize: 20)
    var bodyFont = UIFont.systemFont(ofSize: 17)
    var quoteFont = UIFont.systemFont(ofSize: 17)
    var codeFont = UIFont(name: "menlo", size: 17)!
    var listItemPrefixFont = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular)

    var heading1Color = UIColor.black
    var heading2Color = UIColor.black
    var heading3Color = UIColor.black
    var bodyColor = UIColor.black
    var quoteColor = UIColor.lightGray
    var codeColor = UIColor.darkGray
    var listItemPrefixColor = UIColor.gray

    var headingParagraphStyle: NSMutableParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.paragraphSpacing = 8
        return style
    }()

    var bodyParagraphStyle: NSMutableParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.paragraphSpacingBefore = 8
        style.paragraphSpacing = 8
        return style
    }()

    var maxItemPrefixDigits: UInt = 2
    var spacingAfterItemPrefix: CGFloat = 8
    var spacingAboveItem: CGFloat = 4
    var spacingBelowItem: CGFloat = 8

    // MARK: - Computed Properties

    var fonts: FontCollection {
        FontCollection(
            heading1: heading1Font,
            heading2: heading2Font,
            heading3: heading3Font,
            body: bodyFont,
            quote: quoteFont,
            code: codeFont,
            listItemPrefix: listItemPrefixFont)
    }

    var colors: ColorCollection {
        ColorCollection(
            heading1: heading1Color,
            heading2: heading2Color,
            heading3: heading3Color,
            body: bodyColor,
            quote: quoteColor,
            code: codeColor,
            listItemPrefix: listItemPrefixColor)
    }

    var paragraphStyles: ParagraphStyleCollection {
        ParagraphStyleCollection(
            heading1: headingParagraphStyle,
            heading2: headingParagraphStyle,
            heading3: headingParagraphStyle,
            body: bodyParagraphStyle,
            quote: bodyParagraphStyle,
            code: NSParagraphStyle())
    }

    var listItemOptions: ListItemOptions {
        ListItemOptions(
            maxPrefixDigits: maxItemPrefixDigits,
            spacingAfterPrefix: spacingAfterItemPrefix,
            spacingAbove: spacingAboveItem,
            spacingBelow: spacingBelowItem)
    }

    // MARK: - Lifecycle

    override func setUp() {
        sut = DefaultStyler(fonts: fonts, colors: colors, paragraphStyles: paragraphStyles, listItemOptions: listItemOptions)
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }


    // MARK: - Helpers

    func view(for markdown: String, width: Width) throws -> UIView {
        let textView = UITextView(width: width)
        textView.attributedText = try attributedString(for: markdown)
        textView.resizeToContentSize()
        return textView
    }

    private func attributedString(for markdown: String) throws -> NSAttributedString {
        let down = Down(markdownString: markdown)
        return try down.toAttributedString(styler: sut)
    }
}


extension StylerTestSuite {

    enum Width: CGFloat {
        case narrow = 300
        case wide = 600
    }
}


private extension UITextView {

    convenience init(width: StylerTestSuite.Width) {
        self.init(frame: .init(origin: .zero, size: .init(width: width.rawValue, height: 0)))
    }

    func resizeToContentSize() {
        frame = .init(origin: frame.origin, size: .init(width: contentSize.width, height: contentSize.height))
    }
}
