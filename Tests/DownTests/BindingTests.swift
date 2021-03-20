//
//  BindingTests.swift
//  DownTests
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import Down

class BindingTests: XCTestCase {

    let down = Down(markdownString: "## [Down](https://github.com/johnxnnguyen/Down)")

    func testASTBindingsWork() throws {
        _ = try down.toAST()
    }

    func testHTMLBindingsWork() throws {
        let html = try down.toHTML()
        assertSnapshot(matching: html, as: .lines)
    }

    func testXMLBindingsWork() throws {
        let xml = try down.toXML()
        assertSnapshot(matching: xml, as: .lines)
    }

    func testGroffBindingsWork() throws {
        let man = try down.toGroff()
        assertSnapshot(matching: man, as: .lines)
    }

    func testLaTeXBindngsWork() throws {
        let latex = try down.toLaTeX()
        assertSnapshot(matching: latex, as: .lines)
    }

    func testCommonMarkBindngsWork() throws {
        let commonMark = try down.toCommonMark()
        assertSnapshot(matching: commonMark, as: .lines)
    }

}
