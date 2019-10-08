//
//  HeadingStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 30.07.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

class HeadingStyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone 11** simulator.
    ///

    // MARK: - Heading Levels

    func testThat_Heading_LevelOne_IsStyled() {
        // Given
        let markdown = """
        Praesent facilisis pellentesque ipsum at pulvinar. Sed consectetur augue vel mattis hendrerit.

        # Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit.

        Pellentesque non vulputate felis. Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_Heading_LevelTwo_IsStyled() {
        // Given
        let markdown = """
        Praesent facilisis pellentesque ipsum at pulvinar. Sed consectetur augue vel mattis hendrerit.

        ## Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit.

        Pellentesque non vulputate felis. Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_Heading_LevelThree_IsStyled() {
        // Given
        let markdown = """
        Praesent facilisis pellentesque ipsum at pulvinar. Sed consectetur augue vel mattis hendrerit.

        ### Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit.

        Pellentesque non vulputate felis. Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_Heading_LevelsThreeToSix_AreStyledEqually() {
        // Given
        let markdown = """
        Praesent facilisis pellentesque ipsum at pulvinar. Sed consectetur augue vel mattis hendrerit.

        ### Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit.

        Pellentesque non vulputate felis. Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.

        Praesent facilisis pellentesque ipsum at pulvinar. Sed consectetur augue vel mattis hendrerit.

        #### Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit.

        Pellentesque non vulputate felis. Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.

        Praesent facilisis pellentesque ipsum at pulvinar. Sed consectetur augue vel mattis hendrerit.

        ##### Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit.

        Pellentesque non vulputate felis. Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.

        Praesent facilisis pellentesque ipsum at pulvinar. Sed consectetur augue vel mattis hendrerit.

        ###### Quisque molestie auctor neque. Donec vitae risus non odio viverra hendrerit.

        Pellentesque non vulputate felis. Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    // MARK: - Inline Presevation

    func testThat_HeadingStyle_Preserves_StrongEmphasisAndMonospaceTraits() {
        // Given
        let markdown = """
        # Text **strong _emphasized `code` <html>_**

        Pellentesque non vulputate felis. Curabitur aliquam, nisl vitae vulputate eleifend, metus sapien eleifend.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }
}
