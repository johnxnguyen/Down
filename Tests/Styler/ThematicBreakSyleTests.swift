//
//  ThematicBreakSyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 03.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

class ThematicBreakSyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone 11** simulator.
    ///

    func testThat_ThematicBreak_IsStyled() {
        // Given
        let markdown = """
        # Praesent facilisis pellentesque ipsum at pulvinar.

        ---

        Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit. Pellentesque non vulputate felis.
        Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_ThematicBreak_InOffsetTextContainer_IsStyled() {
        // Given
        let markdown = """
        # Praesent facilisis pellentesque ipsum at pulvinar.

        ---

        Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit. Pellentesque non vulputate felis.
        Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend. Quisque molestie auctor neque.
        Donec vitae risus non odio viverra hendrerit.
        """

        textContainerInset = .init(top: 30, left: 60, bottom: 30, right: 20)

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_ThematicBreak_CanBe_Indented() {
        // Given
        let markdown = """
        # Praesent facilisis pellentesque ipsum at pulvinar.

        ---

        Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit. Pellentesque non vulputate felis.
        Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        var configuration = self.configuration
        configuration.thematicBreakOptions.indentation = 30

        // Then
        assertStyle(for: markdown, width: .wide, configuration: configuration)
    }
}
