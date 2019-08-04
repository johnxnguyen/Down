//
//  ThematicBreakSyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 03.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import Down

class ThematicBreakSyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone Xs** simulator.
    ///

    func testThat_ThematicBreak_IsStyled() {
        // Given
        let markdown = """
        # Praesent facilisis pellentesque ipsum at pulvinar.

        ---

        Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit. Pellentesque non vulputate felis.
        Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
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

        // When
        let result = view(for: markdown, width: .wide)
        result.textContainerInset = .init(top: 30, left: 60, bottom: 30, right: 20)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_ThematicBreak_CanBe_Indented() {
        // Given
        let markdown = """
        # Praesent facilisis pellentesque ipsum at pulvinar.

        ---

        Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit. Pellentesque non vulputate felis.
        Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        styler.thematicBreakOptions.indentation = 30

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }
}
