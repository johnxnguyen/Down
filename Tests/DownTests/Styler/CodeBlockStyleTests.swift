//
//  CodeBlockStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 05.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

class CodeBlockStyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone 11** simulator.
    ///

    func testThat_CodeBlock_IsStyled() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        ```
        func greet(person: Person) {
            print("Hello, \\(person.name)"
        }
        ```

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_HtmlBlock_IsStyled() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        <html>
            <head></head>
            <body></body>
        </html>

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }
}
