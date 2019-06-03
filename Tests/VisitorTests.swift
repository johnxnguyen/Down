//
//  VisitorTests.swift
//  DownTests
//
//  Created by John Nguyen on 08.04.19.
//

import XCTest
@testable import Down

class VisitorTests: XCTestCase {

    func testExample() throws {
        // Given
        let markdown = """
        # Hello
        This is a **test!**
        """
        
        let down = Down(markdownString: markdown)
        let ast = try down.toAST()
        let document = Document(cmarkNode: ast)
        
        // When
        let result = document.accept(DebugVisitor())
        
        // Then
        let expected = """
        Document
            ↳ Heading - L1
                ↳ Text - Hello
            ↳ Paragraph
                ↳ Text - This is a 
                ↳ Strong
                    ↳ Text - test!

        """
        
        XCTAssertEqual(result, expected)
    }
    
    func testAttributedStringVisitor() throws {
        // Given
        let markdown = """
        # Heading
        
        This **is** a *paragraph* with `inline`
        elements <p></p>
        
        This is followed by a hard linebreak\("  ")
        This is after the linebreak
        
        ---
        
        [this is a link](www.text.com)
        ![this is an image](www.text.com)
        
        > this is a quote
        
        ```
        code block
        code block
        ```
        
        <html>
            block
        </html>
        
        1. first item
        2. second item
        """
        
        let down = Down(markdownString: markdown)
        let ast = try down.toAST()
        print(Document(cmarkNode: ast).accept(DebugVisitor()))
        
        // When
        let result = try down.toAttributedString(styler: EmptyStyler()).string
        
        // Then
        let expected = """
        Heading
        This is a paragraph with inline elements <p></p>
        This is followed by a hard linebreak\u{2028}This is after the linebreak
        \u{2028}this is a link this is an image
        this is a quote
        code block
        code block
        <html>
            block
        </html>
        1.\tfirst item
        2.\tsecond item
        """
        
        XCTAssertEqual(result, expected)
    }

}

private class EmptyStyler: Styler {
    var listPrefixAttributes: [NSAttributedString.Key : Any] = [:]
    func style(document str: NSMutableAttributedString) {}
    func style(blockQuote str: NSMutableAttributedString) {}
    func style(list str: NSMutableAttributedString) {}
    func style(item str: NSMutableAttributedString) {}
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

