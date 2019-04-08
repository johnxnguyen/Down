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
        let markdown = "# Hello\n\nThis is a **test!**"
        let down = Down(markdownString: markdown)
        let ast = try down.toAST()
        let document = Document(cmarkNode: ast)!
        let sut = DebugVisitor(document: document)
        
        // When
        let result = sut.result!
        
        // Then
        let expected = "Document -> [Heading: L1, Paragraph -> [Text: 'This is a ', Strong -> [Text: 'test!']]]"
        XCTAssertEqual(result, expected)
    }

}
