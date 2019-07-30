//
//  ListItemStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 28.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import Down

class ListItemStyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone Xs** simulator.
    ///

    // MARK: - Prefix Alignment

    func testThat_DigitPrefixes_UpToMaxPrefixLength_Align() {
        // Given
        let markdown = """
        6. Lorem ipsum dolor sit amet, consectetur adipiscing elit
        7. metus, non placerat velit cursus non. Integer suscipit erat placera
        8. nisi faucibus, convallis enim non
        9. consequat molestie leo
        10. quis pulvinar libero placerat sit
        11. ac rutrum nunc, eget rhoncus nunc
        12. imperdiet pulvinar a eget urna
        """

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_DigitAndBulletPrefixes_Align() {
        // Given
        let markdown = """
        10. quis pulvinar libero placerat sit
        11. ac rutrum nunc, eget rhoncus nunc
        12. imperdiet pulvinar a eget urna

        - Lorem ipsum dolor sit amet, consectetur adipiscing elit
        - metus, non placerat velit cursus non. Integer suscipit erat placera
        - nisi faucibus, convallis enim non
        """

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_DigitPrefixes_ExceedingMaxPrefixLength_Push_FirstLine() {
        // Given
        let markdown = """
        96. Lorem ipsum dolor sit amet, consectetur adipiscing elit
        97. metus, non placerat velit cursus non. Integer suscipit erat placera
        98. nisi faucibus, convallis enim non
        99. consequat molestie leo
        100. quis pulvinar libero placerat sit
        101. ac rutrum nunc, eget rhoncus nunc
        102. imperdiet pulvinar a eget urna
        """

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_DigitPrefixes_ExceedingMaxPrefixLength_DontPush_WrappedLines() {
        // Given
        let markdown = """
        99. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero
        100. vitae sodales metus velit vitae est. Aliquam a dolor magna. In fermentum mattis urna
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    // MARK: - Paragraph Alignment

    func testThat_FirstParagraph_WrappedLines_AlignTo_FirstLine() {
        // Given
        let markdown = """
        1. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero
        vitae sodales metus velit vitae est. Aliquam a dolor magna. In fermentum mattis urna
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_FirstParagraph_WithLineBreaks_AlignTo_FirstLine() {
        // Given
        let markdown = """
        1. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero\\
        Vitae sodales metus velit vitae est. Aliquam a dolor magna. In fermentum mattis urna\\
        Etiam feugiat lectus in euismod egestas. Aenean vehicula finibus justo
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_TrailingParagraphs_FirstLines_AlignTo_FirstParagraph() {
        // Given
        let markdown = """
        1. Phasellus facilisis, nulla non tristique tempor

           Vitae sodales metus velit vitae est. Aliquam a dolor magna

           Etiam feugiat lectus in euismod egestas
        """

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_TrailingParagraphs_WrappedLines_AlignTo_FirstLines() {
        // Given
        let markdown = """
        1. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero

           Vitae sodales metus velit vitae est. Aliquam a dolor magna. In fermentum mattis urna

           Etiam feugiat lectus in euismod egestas. Aenean vehicula finibus justo
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    // MARK: - Nested Lists

    func testThat_NestedList_AlignsTo_OuterList() {
        // Given
        let markdown = """
        1. Lorem ipsum dolor sit amet, consectetur adipiscing elit

            10. metus, non placerat velit cursus non. Integer suscipit erat placera
            11. lectus in euismod egestas

        2. nisi faucibus, convallis enim non

            - consequat molestie leo
            - quis pulvinar libero placerat sit

        3. ac rutrum nunc, eget rhoncus nunc
        4. imperdiet pulvinar a eget urna
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_NestedLists_AlignTo_ParentLists() {
        // Given
        let markdown = """
        1. Lorem ipsum dolor sit amet, consectetur adipiscing elit

            10. metus, non placerat velit cursus non. Integer suscipit erat placera
            11. lectus in euismod egestas

        2. nisi faucibus, convallis enim non

            - consequat molestie leo
            - quis pulvinar libero placerat sit

                20. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero
                21. Vitae sodales metus velit vitae est. Aliquam a dolor magna

        3. ac rutrum nunc, eget rhoncus nunc
        4. imperdiet pulvinar a eget urna
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

//    func testThat_NestedList_InFirstParagraph_StartsOn_NewLine() {
//        XCTFail()
//    }

    func testThat_NestedList_InMiddleParagraph_AlignsTo_OuterList() {
        // Given
        let markdown = """
        1. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero

            10. metus, non placerat velit cursus non. Integer suscipit erat placera
            11. lectus in euismod egestas

        2. vitae sodales metus velit vitae est. Aliquam a dolor magna. In fermentum mattis urna

            - Lorem ipsum dolor sit amet, consectetur adipiscing elit
            - metus, non placerat velit cursus non. Integer suscipit erat placera

           Etiam feugiat lectus in euismod egestas. Aenean vehicula finibus justo
        3. imperdiet pulvinar a eget urna
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_NestedList_InTrailingParagraph_AlignsTo_OuterList() {
        // Given
        let markdown = """
        1. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero

            10. metus, non placerat velit cursus non. Integer suscipit erat placera
            11. lectus in euismod egestas

        2. vitae sodales metus velit vitae est. Aliquam a dolor magna. In fermentum mattis urna
           Etiam feugiat lectus in euismod egestas. Aenean vehicula finibus justo

            - Lorem ipsum dolor sit amet, consectetur adipiscing elit
            - metus, non placerat velit cursus non. Integer suscipit erat placera

        3. imperdiet pulvinar a eget urna
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_NestedList_With_MultipleParagraphs_Align() {
        // Given
        let markdown = """
        1. Phasellus facilisis, nulla non tristique tempor, ligula nisi dignissim libero

            10. metus, non placerat velit cursus non. Integer suscipit erat placera
            11. lectus in euismod egestas

        2. vitae sodales metus velit vitae est. Aliquam a dolor magna. In fermentum mattis urna
           Etiam feugiat lectus in euismod egestas. Aenean vehicula finibus justo

            - Lorem ipsum dolor sit amet, consectetur adipiscing elit

              metus, non placerat velit cursus non. Integer suscipit erat placera

              nisi faucibus, convallis enim nonconsequat molestie leo

            - metus, non placerat velit cursus non. Integer suscipit erat placera

        3. imperdiet pulvinar a eget urna
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    // MARK: - Miscellaneous

//    func testThat_AdjacentLists_Have_VerticalSpacing() {
//        XCTFail()
//    }

    func testThat_ListItems_Preseve_InlineElements() {
        // Given
        let markdown = """
        1. Lorem ipsum **dolor sit** amet, consectetur adipiscing elit
        2. metus, non placerat *velit cursus* non. Integer suscipit erat placera
        3. nisi faucibus, convallis enim non

            - consequat `molestie` leo
            - quis pulvinar libero placerat sit

        4. ac rutrum _**nunc, eget rhoncus**_ nunc
        5. imperdiet <pulvinar> a eget urna
        """

        // When
        let result = view(for: markdown, width: .narrow)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    // TODO: test prefix font and color
}
