//
//  NodeTests.swift
//  DownTests
//
//  Created by John Nguyen on 23.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import XCTest
@testable import Down

class NodeTests: XCTestCase {

    func testTopLevelParagraph() throws {
        // Given
        let sut = NodeVisitor()
        let markdown = """
        This is a top level paragraph.

        1. This item is in a paragraph within a list.

        This is another top level paragraph.
        """

        // When
        parse(markdown, andVisitWith: sut)

        // Then
        XCTAssertEqual(sut.topLevelParagraphResults, [true, false, true])
    }

    func testListDepth() throws {
        // Given
        let sut = NodeVisitor()
        let markdown = """
        1. A1
        2. B1
            * A2
                1. A3
                2. B3
            * B2
        3. C1
        """

        // When
        parse(markdown, andVisitWith: sut)

        // Then
        XCTAssertEqual(sut.listNestDepthResults, [0, 1, 2])
    }
}

// MARK: - Helpers

extension NodeTests {

    private func parse(_ markdown: String, andVisitWith visitor: NodeVisitor) {
        do {
            let ast = try Down(markdownString: markdown).toAST()
            let document = Document(cmarkNode: ast)
            document.accept(visitor)
        } catch {
            XCTFail()
        }
    }
}


private class NodeVisitor: DebugVisitor {

    var topLevelParagraphResults = [Bool]()
    var listNestDepthResults = [Int]()

    override func visit(paragraph node: Paragraph) -> String {
        topLevelParagraphResults.append(node.isTopLevel)
        return super.visit(paragraph: node)
    }

    override func visit(list node: List) -> String {
        listNestDepthResults.append(node.nestDepth)
        return super.visit(list: node)
    }
}
