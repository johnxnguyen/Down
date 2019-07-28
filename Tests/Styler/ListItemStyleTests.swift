//
//  ListItemStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 28.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import XCTest

class ListItemStyleTests: StylerTestSuite {

    // MARK: - Prefix Alignment

    func testThat_DigitPrefixes_UpToMaxPrefixLength_Align() throws {
        XCTFail()
    }

    func testThat_DigitAndBulletPrefixes_Align() throws {
        XCTFail()
    }

    func testThat_DigitPrefixes_ExceedingMaxPrefixLength_Push_FirstLine() throws {
        XCTFail()
    }

    func testThat_DigitPrefixes_ExceedingMaxPrefixLength_DontPush_WrappedLines() throws {
        XCTFail()
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
