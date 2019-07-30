//
//  InlineStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 29.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import XCTest
import SnapshotTesting

class InlineStyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone Xs** simulator.
    ///

    // MARK: - Simple

    func testThat_StrongText_IsStyled() {
        // Given
        let markdown = "Text **strong** text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_EmphasizedText_IsStyled() {
        // Given
        let markdown = "Text _emphasized_ text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_CodeText_IsStyled() {
        // Given
        let markdown = "Text `code` text <html> text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    // MARK: - Double Combinations

    func testThat_StrongEmphasizedText_IsStyled() {
        // Given
        let markdown = "Text **strong _emphasized_ strong** text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_EmphasizedStrongText_IsStyled() {
        // Given
        let markdown = "Text _emphasized **strong** emphasized_ text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_StrongCode_IsStyled() {
        // Given
        let markdown = "Text **strong `code` strong <html> strong** text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_EmphasizedCode_IsStyled() {
        // Given
        let markdown = "Text _emphasized `code` emphasized <html> emphasized_ text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    // MARK: - Triple Combinations

    func testThat_StrongEmphasizedCode_IsStyled() {
        // Given
        let markdown = "Text **strong _emphasized `code` emphasized <html> emphasized_ strong** text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    func testThat_EmphasizedStrongCode_IsStyled() {
        // Given
        let markdown = "Text _emphasized **strong `code` strong <html> strong** emphasized_ text."

        // When
        let result = view(for: markdown, width: .wide)

        // Then
        assertSnapshot(matching: result, as: .image)
    }

    // TODO: fonts, colors and paragraph styles

}
