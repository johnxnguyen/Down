//
//  BlockQuoteStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 04.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

class BlockQuoteStyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone 11** simulator.
    ///

    // MARK: - Alignment

    func testThat_QuoteStripe_AlignsTo_Margin() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        > Curabitur fringilla lacus eget nunc dictum dignissim. Donec cursus magna a libero vulputate maximus.

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    func testThat_QuoteContent_Aligns() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        > Curabitur fringilla lacus eget nunc dictum dignissim. Donec cursus magna a libero vulputate maximus.
        >
        > Donec dignissim iaculis orci et pharetra. Curabitur ac viverra augue, id placerat sapien.

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    func testThat_QuoteAlignment_Obeys_TextContainerOffset() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor.

        > Curabitur fringilla lacus eget nunc dictum dignissim.
        >
        > Donec dignissim iaculis orci et pharetra. Curabitur ac viverra augue, id placerat sapien.

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        textContainerInset = .init(top: 30, left: 30, bottom: 30, right: 30)

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    func testThat_Quotes_WithinA_ListItem_AlignsTo_ListItemContent() {
        // Given
        let markdown = """
        1. Etiam vel dui id purus finibus auctor.
        2. Donec in semper lectus. Vestibulum vel eleifend justo.
            > Curabitur fringilla lacus eget nunc dictum dignissim.
            > Donec cursus magna a libero vulputate maximus.
        3. Nunc vitae tellus eget purus sagittis aliquet.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    func testThat_QuotedList_WithinA_ListItem_AlignsCorrectly() {
        // Given
        let markdown = """
        1. Etiam vel dui id purus finibus auctor.
        2. Donec in semper lectus. Vestibulum vel eleifend justo.
            > 10. Curabitur fringilla lacus eget nunc dictum dignissim.
            > 11. Donec cursus magna a libero vulputate maximus.
        3. Nunc vitae tellus eget purus sagittis aliquet.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    // MARK: - Preservation

    func testThat_QuoteContent_Preserves_InlineElements() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        > Text **strong _emphasis `code` <html>_**

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    func testThat_QuoteContent_Preserves_BlockElements() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        > # Block elements
        >
        > ```
        > func greet(person: Person) {
        >     print("Hello, \\(person.name)"
        > }
        > ```
        >
        > <html>
        >     <head></head>
        >     <body></body>
        > </html>

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_QuoteContent_Preserves_ListFormatting() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        > Duis quis tortor auctor, varius nisi ultrices, tincidunt nisl.
        >
        > 1. Mauris aliquam magna eget odio.
        > 2. Curabitur fermentum pellentesque viverra.
        >
        >     10. Suspendisse convallis quam suscipit ultrices pulvinar.
        >     11. Nunc vitae tellus eget purus sagittis aliquet.
        >
        > 3. Quisque hendrerit sit amet dolor ut convallis.
        >
        >     - Donec vitae justo gravida, convallis augue vitae, consequat libero.
        >
        > 4. Suspendisse finibus vehicula orci.
        >
        > Curabitur tempor metus eros, nec laoreet nisi tempus a.

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    func testThat_QuoteContent_Preserves_ThematicBreak() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        > # Donec vitae justo gravida
        > ---
        >
        > Curabitur fringilla lacus eget nunc dictum dignissim. Donec cursus magna a libero vulputate maximus.

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .narrow)
    }

    // MARK: - Nested Quotes

    func testThat_NestedQuotes_Have_TheirOwnStripes() {
        // Given
        let markdown = """
        Etiam vel dui id purus finibus auctor. Donec in semper lectus. Vestibulum vel eleifend justo.

        > Curabitur fringilla lacus eget nunc dictum dignissim. Donec cursus magna a libero vulputate maximus.
        >
        >> Quisque hendrerit sit amet dolor ut convallis. Donec vitae justo gravida, convallis augue vitae.
        >> Etiam porttitor sed leo nec commodo. Mauris ut lobortis erat.
        >>
        >>> Etiam odio sapien, blandit non scelerisque non, auctor eu leo.
        >>
        >> Maecenas nec metus posuere, iaculis sapien rhoncus, fermentum diam.
        >
        > Suspendisse egestas ex at bibendum tempor. Integer tellus tortor.
        >
        >> Porta sed bibendum id, semper id dolor.

        Duis ultrices dapibus diam nec mollis. Mauris scelerisque massa nec tristique dapibus. Mauris sed tempor lorem.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }
}

