//
//  BindingTests.swift
//  DownTests
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import XCTest
@testable import Down

class BindingTests: XCTestCase {

    let down = Down(markdownString: "## [Down](https://github.com/iwasrobbed/Down)")

    func testASTBindingsWork() {
        let ast = try? down.toAST()
        XCTAssertNotNil(ast)
    }

    func testHTMLBindingsWork() {
        let html = try? down.toHTML()
        XCTAssertNotNil(html)
        XCTAssertTrue(html == "<h2><a href=\"https://github.com/iwasrobbed/Down\">Down</a></h2>\n")
    }

    func testXMLBindingsWork() {
        let xml = try? down.toXML()
        XCTAssertNotNil(xml)
        XCTAssertTrue(xml == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE document SYSTEM \"CommonMark.dtd\">\n<document xmlns=\"http://commonmark.org/xml/1.0\">\n  <heading level=\"2\">\n    <link destination=\"https://github.com/iwasrobbed/Down\" title=\"\">\n      <text>Down</text>\n    </link>\n  </heading>\n</document>\n")
    }

    func testGroffBindingsWork() {
        let man = try? down.toGroff()
        XCTAssertNotNil(man)
        XCTAssertTrue(man == ".SS\nDown (https://github.com/iwasrobbed/Down)\n")
    }

    func testLaTeXBindngsWork() {
        let latex = try? down.toLaTeX()
        XCTAssertNotNil(latex)
        XCTAssertTrue(latex == "\\subsection{\\href{https://github.com/iwasrobbed/Down}{Down}}\n")
    }

    func testCommonMarkBindngsWork() {
        let commonMark = try? down.toCommonMark()
        XCTAssertNotNil(commonMark)
        XCTAssertTrue(commonMark == "## [Down](https://github.com/iwasrobbed/Down)\n")
    }
    
}
