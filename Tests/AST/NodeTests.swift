//
//  NodeTests.swift
//  DownTests
//
//  Created by John Nguyen on 23.06.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
@testable import Down

class NodeTests: XCTestCase {

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

    var listNestDepthResults = [Int]()

    override func visit(list node: List) -> String {
        listNestDepthResults.append(node.nestDepth)
        return super.visit(list: node)
    }
}
