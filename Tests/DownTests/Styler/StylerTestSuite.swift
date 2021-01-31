//
//  StylerTestSuite.swift
//  DownTests
//
//  Created by John Nguyen on 27.07.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import Down

class StylerTestSuite: XCTestCase {

    // MARK: - Properties

    let configuration = DownStylerConfiguration.testConfiguration

    var textContainerInset: UIEdgeInsets!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        textContainerInset = .init(top: 8, left: 8, bottom: 8, right: 8)
    }

    override func tearDown() {
        textContainerInset = nil
        super.tearDown()
    }

    // MARK: - Helpers

    func assertStyle(
        for markdown: String,
        width: Width,
        configuration: DownStylerConfiguration? = nil,
        showLineFragments: Bool = false,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line) {

        let view = self.view(for: markdown, width: width, configuration: configuration, showLineFragments: showLineFragments)

        let failure = verifySnapshot(matching: view, as: .image, record: recording, file: file, testName: testName, line: line)

        guard let message = failure else { return }
        XCTFail(message, file: file, line: line)
    }

    func view(for markdown: String, width: Width, configuration: DownStylerConfiguration?, showLineFragments: Bool = false) -> DownTextView {
        // To make the snapshots the same size of the text content, we set a huge height then resize the view
        // to the content size.
        let frame = CGRect(x: 0, y: 0, width: width.rawValue, height: 5000)
        let textView = showLineFragments ? DownDebugTextView(frame: frame) : DownTextView(frame: frame)
        textView.textContainerInset = textContainerInset
        textView.attributedText = attributedString(for: markdown, configuration: configuration)
        textView.resizeToContentSize()
        return textView
    }

    private func attributedString(for markdown: String, configuration: DownStylerConfiguration?) -> NSAttributedString {
        let down = Down(markdownString: markdown)
        let styler = DownStyler(configuration: configuration ?? .testConfiguration)
        return try! down.toAttributedString(styler: styler)
    }
}


extension StylerTestSuite {

    enum Width: CGFloat {
        case narrow = 300
        case wide = 600
    }
}


private extension DownTextView {

    func resizeToContentSize() {
        frame = .init(origin: frame.origin, size: .init(width: contentSize.width, height: contentSize.height))
    }
}

private extension DownStylerConfiguration {

    static var testConfiguration: DownStylerConfiguration {
        var fonts = StaticFontCollection()
        fonts.heading1 = .systemFont(ofSize: 28)
        fonts.heading2 = .systemFont(ofSize: 24)
        fonts.heading3 = .systemFont(ofSize: 20)
        fonts.heading4 = .systemFont(ofSize: 20)
        fonts.heading5 = .systemFont(ofSize: 20)
        fonts.heading6 = .systemFont(ofSize: 20)
        fonts.body = .systemFont(ofSize: 17)
        fonts.code = UIFont(name: "menlo", size: 17)!
        fonts.listItemPrefix = .monospacedDigitSystemFont(ofSize: 17, weight: .regular)

        var colors = StaticColorCollection()
        colors.heading1 = #colorLiteral(red: 0.7803921569, green: 0, blue: 0.2235294118, alpha: 1)
        colors.heading2 = #colorLiteral(red: 1, green: 0.3411764706, blue: 0.2, alpha: 1)
        colors.heading3 = #colorLiteral(red: 1, green: 0.7647058824, blue: 0.05882352941, alpha: 1)
        colors.heading4 = #colorLiteral(red: 1, green: 0.7647058824, blue: 0.05882352941, alpha: 1)
        colors.heading5 = #colorLiteral(red: 1, green: 0.7647058824, blue: 0.05882352941, alpha: 1)
        colors.heading6 = #colorLiteral(red: 1, green: 0.7647058824, blue: 0.05882352941, alpha: 1)
        colors.body = .black
        colors.code = .darkGray
        colors.codeBlockBackground = #colorLiteral(red: 0.9647058824, green: 0.9725490196, blue: 0.9803921569, alpha: 1)
        colors.link = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        colors.quote = .lightGray
        colors.quoteStripe = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        colors.thematicBreak = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        colors.listItemPrefix = .gray

        var paragraphStyles = StaticParagraphStyleCollection()
        let headingParagraphStyle = NSMutableParagraphStyle()
        headingParagraphStyle.paragraphSpacing = 8

        let bodyParagraphStyle = NSMutableParagraphStyle()
        bodyParagraphStyle.paragraphSpacingBefore = 8
        bodyParagraphStyle.paragraphSpacing = 8

        paragraphStyles.heading1 = headingParagraphStyle
        paragraphStyles.heading2 = headingParagraphStyle
        paragraphStyles.heading3 = headingParagraphStyle
        paragraphStyles.heading4 = headingParagraphStyle
        paragraphStyles.heading5 = headingParagraphStyle
        paragraphStyles.heading6 = headingParagraphStyle
        paragraphStyles.body = bodyParagraphStyle
        paragraphStyles.code = bodyParagraphStyle

        var listItemOptions = ListItemOptions()
        listItemOptions.maxPrefixDigits = 2
        listItemOptions.spacingAfterPrefix = 8
        listItemOptions.spacingAbove = 4
        listItemOptions.spacingBelow = 8

        var quoteStripeOptions = QuoteStripeOptions()
        quoteStripeOptions.thickness = 3
        quoteStripeOptions.spacingAfter = 8

        var thematicBreakOptions = ThematicBreakOptions()
        thematicBreakOptions.thickness = 1
        thematicBreakOptions.indentation = 0

        var configuration = DownStylerConfiguration()
        configuration.fonts = fonts
        configuration.colors = colors
        configuration.paragraphStyles = paragraphStyles
        configuration.listItemOptions = listItemOptions
        configuration.quoteStripeOptions = quoteStripeOptions
        configuration.thematicBreakOptions = thematicBreakOptions

        configuration.codeBlockOptions = CodeBlockOptions()
        configuration.codeBlockOptions.containerInset = 8

        return configuration
    }
}
