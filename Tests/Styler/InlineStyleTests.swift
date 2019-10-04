//
//  InlineStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 29.07.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

class InlineStyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone 11** simulator.
    ///

    // MARK: - Simple

    func testThat_StrongText_IsStyled() {
        // Given
        let markdown = "Text **strong** text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_EmphasizedText_IsStyled() {
        // Given
        let markdown = "Text _emphasized_ text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_CodeText_IsStyled() {
        // Given
        let markdown = "Text `code` text <html> text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    // MARK: - Double Combinations

    func testThat_StrongEmphasizedText_IsStyled() {
        // Given
        let markdown = "Text **strong _emphasized_ strong** text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_EmphasizedStrongText_IsStyled() {
        // Given
        let markdown = "Text _emphasized **strong** emphasized_ text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_StrongCode_IsStyled() {
        // Given
        let markdown = "Text **strong `code` strong <html> strong** text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_EmphasizedCode_IsStyled() {
        // Given
        let markdown = "Text _emphasized `code` emphasized <html> emphasized_ text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    // MARK: - Triple Combinations

    func testThat_StrongEmphasizedCode_IsStyled() {
        // Given
        let markdown = "Text **strong _emphasized `code` emphasized <html> emphasized_ strong** text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }

    func testThat_EmphasizedStrongCode_IsStyled() {
        // Given
        let markdown = "Text _emphasized **strong `code` strong <html> strong** emphasized_ text."

        // Then
        assertStyle(for: markdown, width: .wide)
    }
}
