//
//  DownDebugLayoutManagerTests.swift
//  DownTests
//
//  Created by John Nguyen on 08.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

class DownDebugLayoutManagerTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone 11** simulator.
    ///

    func testThat_LineFragments_AreDrawn() {
        // Given
        let markdown = """
        # Curabitur fringilla lacus eget nunc dictum dignissim.
        ---

        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        > Curabitur fringilla lacus eget nunc dictum dignissim. Donec cursus magna a libero vulputate maximus.
        > Donec dignissim iaculis orci et pharetra. Curabitur ac viverra augue, id placerat sapien.

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.

        1. Etiam vel dui id purus finibus auctor.
        2. Donec in semper lectus. Vestibulum vel eleifend justo.
            > Curabitur fringilla lacus eget nunc dictum dignissim.
            > Donec cursus magna a libero vulputate maximus.
        3. Nunc vitae tellus eget purus sagittis aliquet.

        Suspendisse egestas ex at bibendum tempor. Integer tellus tortor.
        """

        // Then
        assertStyle(for: markdown, width: .wide, showLineFragments: true)
    }
}
