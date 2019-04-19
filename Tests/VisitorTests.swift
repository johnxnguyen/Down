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
        let document = Document(cmarkNode: ast)!
        
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
    
    func testTraversal() throws {
        // Given
        let markdown = """
        # Text

        text **text** text *text* text `text`
        text <text>text</text>

        text\("  ")
        text

        ---

        [text](www.text.com)
        ![text](www.text.com)

        > text

        ```
        text
        ```
        
        <text>
            text
        </text>

        1. text
        2. text
        """
        
        let down = Down(markdownString: markdown)
        let ast = try down.toAST()
        let document = Document(cmarkNode: ast)!
        let visitor = TestVisitor()
        
        // When
        _ = document.accept(visitor)
        
        // Then
        let expected = [
            "Document",
                "Heading",
                    "Text",
                "Paragraph",
                    "Text",
                    "Strong",
                        "Text",
                    "Text",
                    "Emphasis",
                        "Text",
                    "Text",
                    "Code",
                    "SoftBreak",
                    "Text",
                    "HtmlInline",
                    "Text",
                    "HtmlInline",
                "Paragraph",
                    "Text",
                    "LineBreak",
                    "Text",
                "ThematicBreak",
                "Paragraph",
                    "Link",
                        "Text",
                    "SoftBreak",
                    "Image",
                        "Text",
                "BlockQuote",
                    "Paragraph",
                        "Text",
                "CodeBlock",
                "HtmlBlock",
                "List",
                    "Item",
                        "Paragraph",
                            "Text",
                    "Item",
                        "Paragraph",
                            "Text"
        ]
        
        XCTAssertEqual(visitor.sequence, expected)
    }

}

private class TestVisitor: Visitor {
    
    typealias Result = ()
    
    var sequence = [String]()
    
    func visit(document node: Document)             { record(node) }
    func visit(blockQuote node: BlockQuote)         { record(node) }
    func visit(list node: List)                     { record(node) }
    func visit(item node: Item)                     { record(node) }
    func visit(codeBlock node: CodeBlock)           { record(node) }
    func visit(htmlBlock node: HtmlBlock)           { record(node) }
    func visit(customBlock node: CustomBlock)       { record(node) }
    func visit(paragraph node: Paragraph)           { record(node) }
    func visit(heading node: Heading)               { record(node) }
    func visit(thematicBreak node: ThematicBreak)   { record(node) }
    func visit(text node: Text)                     { record(node) }
    func visit(softBreak node: SoftBreak)           { record(node) }
    func visit(lineBreak node: LineBreak)           { record(node) }
    func visit(code node: Code)                     { record(node) }
    func visit(htmlInline node: HtmlInline)         { record(node) }
    func visit(customInline node: CustomInline)     { record(node) }
    func visit(emphasis node: Emphasis)             { record(node) }
    func visit(strong node: Strong)                 { record(node) }
    func visit(link node: Link)                     { record(node) }
    func visit(image node: Image)                   { record(node) }
    
    func record(_ node: Node) {
        sequence.append(String(describing: type(of: node)))
        _ = visitChildren(of: node)
    }
}
