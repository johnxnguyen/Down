//
//  ListItemStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 28.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import XCTest
import SnapshotTesting

class ListItemStyleTests: StylerTestSuite {

    // MARK: - Prefix Alignment

    func testThat_DigitPrefixes_UpToMaxPrefixLength_Align() throws {
        // Given
        let markdown = """
        6. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        7. metus, non placerat velit cursus non. Integer suscipit erat placera
        8. nisi faucibus, convallis enim non
        9. consequat molestie leo
        10. quis pulvinar libero placerat sit
        11. ac rutrum nunc, eget rhoncus nunc
        12. imperdiet pulvinar a eget urna
        """

        // When
        let result = try view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_DigitAndBulletPrefixes_Align() throws {
        // Given
        let markdown = """
        10. quis pulvinar libero placerat sit
        11. ac rutrum nunc, eget rhoncus nunc
        12. imperdiet pulvinar a eget urna

        - Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        - metus, non placerat velit cursus non. Integer suscipit erat placera
        - nisi faucibus, convallis enim non
        """

        // When
        let result = try view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_DigitPrefixes_ExceedingMaxPrefixLength_Push_FirstLine() throws {
        // Given
        let markdown = """
        96. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        97. metus, non placerat velit cursus non. Integer suscipit erat placera
        98. nisi faucibus, convallis enim non
        99. consequat molestie leo
        100. quis pulvinar libero placerat sit
        101. ac rutrum nunc, eget rhoncus nunc
        102. imperdiet pulvinar a eget urna
        """

        // When
        let result = try view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_DigitPrefixes_ExceedingMaxPrefixLength_DontPush_WrappedLines() throws {
        // Given
        let markdown = """
        99. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero.
        100. vitae sodales metus velit vitae est. Aliquam a dolor magna. In fermentum mattis urna
        """

        // When
        let result = try view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    // MARK: - Paragraph Alignment

    func testThat_FirstParagraphs_WrappedLines_AlignTo_FirstLine() throws {
        XCTFail()
    }

    func testThat_TrailingParagraphs_FirstLines_AlignTo_FirstParagraph() throws {
        XCTFail()
    }

    func testThat_TrailingParagraphs_WrappedLines_AlignTo_FirstLines() throws {
        XCTFail()
    }

    // MARK: - Vertical Spacing

    func testThat_AdjacentLists_Have_VerticalSpacing() throws {
        XCTFail()
    }

    // MARK: - Configurable Options

    func testThat_MaxPrefixDigits_CanBeAdjusted() throws {
        // Include wrapped lines and paragraphs
        XCTFail()
    }

    func testThat_SpacingAfterPrefix_CanBeAdjusted() throws {
        // Include wrapped lines and paragraphs
        XCTFail()
    }

    func testThat_SpacingAbove_CanBeAdjusted() throws {
        // Change the above
        XCTFail()
    }

    func testThat_SpacingBelow_CanBeAdjusted() throws {
        // Change the below constants
        XCTFail()
    }

    // MARK: - Nested Lists

    func testThat_NestedList_AlignsTo_OuterList() throws {
        // Single nested list
        XCTFail()
    }

    func testThat_NestedLists_AlignTo_ParentLists() throws {
        // Multiple nested lists
        XCTFail()
    }

    func testThat_NestedList_InFirstParagraph_StartsOn_NewLine() throws {
        XCTFail()
    }

    func testThat_NestedList_InMiddleParagraph_AlignsTo_OuterList() throws {
        XCTFail()
    }

    func testThat_NestedList_InTrailingParagraph_AlignsTo_OuterList() throws {
        XCTFail()
    }

    func testThat_NestedList_With_MultipleParagraphs_Align() throws {
        XCTFail()
    }

}
