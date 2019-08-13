//
//  VisitorTests.swift
//  DownTests
//
//  Created by John Nguyen on 08.04.19.
//

import XCTest
import SnapshotTesting
@testable import Down

class VisitorTests: XCTestCase {

    func result(for markdown: String) -> String {
        let down = Down(markdownString: markdown)
        return try! down.toAttributedString(styler: EmptyStyler()).string
    }

    func debugResult(for markdown: String) -> String {
        let down = Down(markdownString: markdown)
        let ast = try! down.toAST()
        let document = Document(cmarkNode: ast)
        return document.accept(DebugVisitor())
    }

    func testBlockQuote() {
        // Given
        let markdown = """
        Text text.

        > Quote
        > Quote

        > Quote
        > Quote
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testList() {
        // Given
        let markdown = """
        Text text.

        3. One
        3. Two
            - Three
            - Four
        3. Five

        Text text.
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testCodeBlock() {
        // Given
        let markdown = """
        Text text.

        ```
        Code block
        Code block
        ```

        Text text.
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testHtmlBlock() {
        // Given
        let markdown = """
        Text text.

        <html>
            <head></head>
        </html>

        Text text.
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testParagraph() {
        // Given
        let markdown = """
        Text text.

        Text text.

        Text text.
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testHeading() {
        // Given
        let markdown = """
        Text text.

        # Heading

        Text text.
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testThematicBreak() {
        // Given
        let markdown = """
        Text text.

        ---

        Text text.
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testSoftBreak() {
        // Given
        let markdown = """
        Text text
        text text
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testLineBreak() {
        // Given
        let markdown = """
        Text text.\\
        Text text.
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testInline() {
        // Given
        let markdown = """
        Text **strong _emphasis `code` <html>_**
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }

    func testLink() {
        // Given
        let markdown = """
        Text [link](www.example.com) text ![image](www.example.com)
        """

        // Then
        assertSnapshot(matching: result(for: markdown), as: .lines)
        assertSnapshot(matching: debugResult(for: markdown), as: .lines)
    }
}

private class EmptyStyler: Styler {
    var listPrefixAttributes: [NSAttributedString.Key : Any] = [:]
    func style(document str: NSMutableAttributedString) {}
    func style(blockQuote str: NSMutableAttributedString, nestDepth: Int) {}
    func style(list str: NSMutableAttributedString, nestDepth: Int) {}
    func style(listItemPrefix str: NSMutableAttributedString) {}
    func style(item str: NSMutableAttributedString, prefixLength: Int) {}
    func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {}
    func style(htmlBlock str: NSMutableAttributedString) {}
    func style(customBlock str: NSMutableAttributedString) {}
    func style(paragraph str: NSMutableAttributedString) {}
    func style(heading str: NSMutableAttributedString, level: Int) {}
    func style(thematicBreak str: NSMutableAttributedString) {}
    func style(text str: NSMutableAttributedString) {}
    func style(softBreak str: NSMutableAttributedString) {}
    func style(lineBreak str: NSMutableAttributedString) {}
    func style(code str: NSMutableAttributedString) {}
    func style(htmlInline str: NSMutableAttributedString) {}
    func style(customInline str: NSMutableAttributedString) {}
    func style(emphasis str: NSMutableAttributedString) {}
    func style(strong str: NSMutableAttributedString) {}
    func style(link str: NSMutableAttributedString, title: String?, url: String?) {}
    func style(image str: NSMutableAttributedString, title: String?, url: String?) {}
}
