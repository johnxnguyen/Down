//
//  LinkStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 08.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

class LinkStyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone 11** simulator.
    ///

    func testThat_Link_IsStyled() {
        // Given
        let markdown = """
        Praesent facilisis [pellentesque](www.example.com) ipsum at pulvinar. Sed consectetur augue vel mattis hendrerit.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    func testThat_Link_Preserves_InlineStyles() {
        // Given
        let markdown = """
        Praesent facilisis [**pellentesque _ipsum `at` <pulvinar>_**](www.example.com). Sed consectetur augue.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }
}
