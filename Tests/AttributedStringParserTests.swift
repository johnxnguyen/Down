////
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import XCTest
@testable import Down

class AttributedStringParserTests: XCTestCase {
    
    var sut = AttributedStringParser()
    
    // MARK: - Helpers
    
    func text(_ str: String, with markdown: Markdown...) -> NSAttributedString {
        return NSAttributedString(string: str, attributes: [.markdown: Markdown(markdown)])
    }
    
    func combine(_ components: NSAttributedString...) -> NSAttributedString {
        let result = NSMutableAttributedString(string: "")
        components.forEach(result.append)
        return result
    }
    
    // MARK: - Non Nested
    
    // these are the simplest cases
    
    func testThatItParses_H1() {
        // GIVEN
        let input = text("H1", with: .h1)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("# \(input.string)\n", result)
    }
    
    func testThatItParses_H2() {
        // GIVEN
        let input = text("H2", with: .h2)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("## \(input.string)\n", result)
    }
    
    func testThatItParses_H3() {
        // GIVEN
        let input = text("H3", with: .h3)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("### \(input.string)\n", result)
    }
    
    func testThatItParses_Bold() {
        // GIVEN
        let input = text("Bold", with: .bold)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("**\(input.string)**", result)
    }
    
    func testThatItParses_Italic() {
        // GIVEN
        let input = text("Italic", with: .italic)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("_\(input.string)_", result)
    }
    
    func testThatItParses_Code() {
        // GIVEN
        let input = text("Code", with: .code)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("`\(input.string)`", result)
    }
    
    // MARK: - Nested
    
    // these cases involve strings where one markdown is applied to the
    // whole string, and another markdown is applied to a substring
    
    func testThatItParses_BoldItalic() {
        // GIVEN
        let input = text("BoldItalic", with: .bold, .italic)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("**_\(input.string)_**", result)
    }
    
    func testThatItParses_H1Bold() {
        // GIVEN
        let input = text("H1Bold", with: .h1, .bold)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("# **\(input.string)**\n", result)
    }
    
    func testThatItParses_H1Italic() {
        // GIVEN
        let input = text("H1Italic", with: .h1, .italic)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("# _\(input.string)_\n", result)
    }
    
    func testThatItParses_H1Code() {
        // GIVEN
        let input = text("H1Code", with: .h1, .code)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("# `\(input.string)`\n", result)
    }
    
    func testThatItParses_H1BoldItalic() {
        // GIVEN
        let input = text("H1BoldItalic", with: .h1, .bold, .italic)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("# **_\(input.string)_**\n", result)
    }
    
    // MARK: True Substring Nesting
    
    func testThatItParses_BoldItalic_Italic() {
        // GIVEN
        let BI = text("BoldItalic", with: .bold, .italic)
        let I = text(" Italic", with: .italic)
        let input = combine(BI, I)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("_**\(BI.string)**" + "\(I.string)_" , result)
    }
    
    func testThatItParses_BoldItalic_Bold() {
        // GIVEN
        let BI = text("BoldItalic", with: .bold, .italic)
        let B = text(" Bold", with: .bold)
        let input = combine(BI, B)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        XCTAssertEqual("**_\(BI.string)_" + "\(B.string)**" , result)
    }
    
    func testThatItParses_H1_BoldItalic() {
        // GIVEN
        let H1 = text("H1 ", with: .h1)
        let H1BI = text("BoldItalic", with: .h1, .bold, .italic)
        let input = combine(H1, H1BI)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "# \(H1.string)" + "**_\(H1BI.string)_**\n"
        XCTAssertEqual(expectation , result)
    }
    
    func testThatItParses_Bold_BoldItalic_Bold() {
        // GIVEN
        let B = text("Bold", with: .bold)
        let BI = text(" BoldItalic ", with: .bold, .italic)
        let input = combine(B, BI, B)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "**\(B.string)" + " _\(BI.string.trimmed)_ " + "\(B.string)**"
        XCTAssertEqual(expectation , result)
    }
    
    func testThatItParses_Italic_BoldItalic_Italic() {
        // GIVEN
        let I = text("Italic", with: .italic)
        let BI = text(" BoldItalic ", with: .bold, .italic)
        let input = combine(I, BI, I)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "_\(I.string)" + " **\(BI.string.trimmed)** " + "\(I.string)_"
        XCTAssertEqual(expectation , result)
    }
    
    // MARK: Multiple Nesting
    
    func testThatItParses_H1_H1Bold_H1Italic_H1Code() {
        // GIVEN
        let H1 = text("H1 ", with: .h1)
        let H1B = text("Bold ", with: .h1, .bold)
        let H1I = text("Italic ", with: .h1, .italic)
        let H1C = text("Code", with: .h1, .code)
        let input = combine(H1, H1B, H1I, H1C)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation =
            "# \(H1.string)" + "**\(H1B.string.trimmed)** "
            + "_\(H1I.string.trimmed)_ " + "`\(H1C.string)`\n"
        
        XCTAssertEqual(expectation , result)
    }
    
    func testThatItParses_BoldItalic_Italic_BoldItalic() {
        // GIVEN
        let BI = text("BoldItalic", with: .bold, .italic)
        let I = text(" Italic ", with: .italic)
        let input = combine(BI, I, BI)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "_**\(BI.string)**" + I.string + "**\(BI.string)**_"
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItParses_BoldItalic_Bold_BoldItalic() {
        // GIVEN
        let BI = text("BoldItalic", with: .bold, .italic)
        let B = text(" Bold ", with: .bold)
        let input = combine(BI, B, BI)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "**_\(BI.string)_" + B.string + "_\(BI.string)_**"
        XCTAssertEqual(expectation, result)
    }
    
    // MARK: - Nested Overlapping
    
    func testThatItParses_Bold_BoldItalic_Italic() {
        // GIVEN
        let B = text("Bold", with: .bold)
        let BI = text(" BoldItalic ", with: .bold, .italic)
        let I = text("Italic", with: .italic)
        let input = combine(B, BI, I)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "**\(B.string)" + " _\(BI.string.trimmed)_** " + "_\(I.string)_"
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItParses_Italic_BoldItalic_Bold() {
        // GIVEN
        let I = text("Italic", with: .italic)
        let BI = text(" BoldItalic ", with: .bold, .italic)
        let B = text("Bold", with: .bold)
        let input = combine(I, BI, B)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "_\(I.string)" + " **\(BI.string.trimmed)**_ " + "**\(B.string)**"
        XCTAssertEqual(expectation, result)
    }
    
    // MARK: - Disjoint Components
    
    func testThatItParses_H1_Bold_Italic_Code() {
        // GIVEN
        let H1 = text("H1", with: .h1)
        let B = text("Bold ", with: .bold)
        let I = text("Italic ", with: .italic)
        let C = text("Code", with: .code)
        let input = combine(H1, B, I, C)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation =
                "# \(H1.string)\n"
                + "**\(B.string.trimmed)** " + "_\(I.string.trimmed)_ " + "`\(C.string)`"
        
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItParses_H1_BoldItalic_Code_BoldItalic() {
        // GIVEN
        let H1 = text("H1", with: .h1)
        let BI = text("BoldItalic ", with: .bold, .italic)
        let C = text("Code ", with: .code)
        let input = combine(H1, BI, C, BI)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation =
            "# \(H1.string)\n"
            + "**_\(BI.string.trimmed)_** " + "`\(C.string.trimmed)` " + "**_\(BI.string.trimmed)_** "
        
        XCTAssertEqual(expectation, result)
    }
    
    // MARK: - Input Preparation (Excluding Whitespace)
    
    func testThatItExcludesLeadingAndTrailingWhiteSpaces_Bold() {
        // GIVEN
        let whitespace = text("  \t  ", with: .bold)
        let B = text("Bold", with: .bold)
        let input = combine(whitespace, B, whitespace)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = whitespace.string + "**\(B.string)**" + whitespace.string
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItExcludesLeadingAndTrailingWhiteSpaces_Italic() {
        // GIVEN
        let whitespace = text("  \t  ", with: .italic)
        let I = text("Italic", with: .italic)
        let input = combine(whitespace, I, whitespace)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = whitespace.string + "_\(I.string)_" + whitespace.string
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItExcludesLeadingAndTrailingWhiteSpaces_Code() {
        // GIVEN
        let whitespace = text("  \t  ", with: .code)
        let C = text("Code", with: .code)
        let input = combine(whitespace, C, whitespace)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = whitespace.string + "`\(C.string)`" + whitespace.string
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItExcludesLeadingAndTrailingWhiteSpaces_BoldItalic() {
        // GIVEN
        let whitespace = text("  \t  ", with: .bold, .italic)
        let BI = text("BoldItalic", with: .bold, .italic)
        let input = combine(whitespace, BI, whitespace)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = whitespace.string + "**_\(BI.string)_**" + whitespace.string
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItExcludesLeadingWhitespaceFromMarkdownWhenOverlapped() {
        // GIVEN
        let input = combine(
            text("Bold", with: .bold),
            text(" BoldItalic ", with: .bold, .italic),
            text("Italic", with: .italic)
        )
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "**Bold _BoldItalic_** _Italic_"
        XCTAssertEqual(expectation, result)
    }
    
    func testThatStringsContainingOnlyWhiteSpaceProduceNoMarkdownSyntax() {
        // GIVEN
        let B = text("  \t  ", with: .bold)
        let I = text("  \t  ", with: .italic)
        let C = text("  \t  ", with: .code)
        let input = combine(B, I, C)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = B.string + I.string + C.string
        XCTAssertEqual(expectation, result)
    }
    
    // MARK: - Input Preparation (Newlines)
    
    func testThatItParsesMultiline_Bold() {
        // GIVEN
        let B = text("Bold", with: .bold)
        let N = text("\n", with: .bold)
        let input = combine(B, N, B)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "**\(B.string)**" + N.string + "**\(B.string)**"
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItParsesMultiline_Italic() {
        // GIVEN
        let I = text("Italic", with: .italic)
        let N = text("\n", with: .italic)
        let input = combine(I, N, I)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "_\(I.string)_" + N.string + "_\(I.string)_"
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItParsesMultiline_Code() {
        // GIVEN
        let C = text("Bold", with: .code)
        let N = text("\n", with: .code)
        let input = combine(C, N, C)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "`\(C.string)`" + N.string + "`\(C.string)`"
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItParsesMultiline_BoldItalic() {
        // GIVEN
        let BI = text("Bold", with: .bold, .italic)
        let N = text("\n", with: .bold, .italic)
        let input = combine(BI, N, BI)
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation = "**_\(BI.string)_**" + N.string + "**_\(BI.string)_**"
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItInsertsNewlineAfterHeaderIfOneIsMissing() {
        // GIVEN
        let input = combine(
            text("H1", with: .h1),
            text("Normal\n", with: .none),
            text("H2", with: .h2),
            text("Normal\n", with: .none),
            text("H3", with: .h3),
            text("Normal", with: .none)
        )
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation =   """
                            # H1
                            Normal
                            ## H2
                            Normal
                            ### H3
                            Normal
                            """
        XCTAssertEqual(expectation, result)
    }
    
    func testThatItDoesNotInsertNewlineAfterHeaderIfOneIsAlreadyPresent() {
        // GIVEN
        let input = combine(
            text("H1", with: .h1),
            text("\nNormal\n", with: .none),
            text("H2\n", with: .h2),
            text("Normal\n", with: .none),
            text("H3", with: .h3),
            text("\nNormal", with: .none)
        )
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation =   """
                            # H1
                            Normal
                            ## H2
                            Normal
                            ### H3
                            Normal
                            """
        XCTAssertEqual(expectation, result)
    }
    
    // MARK: - Long Input
    
    func testThatItParsesLongInput() {
        // GIVEN
        let input = combine(
            text("This is a header!", with: .h1),
            text("This is normal text. ", with: .none),
            text("This text is in bold. ", with: .bold),
            text("Here is some more normal text but ", with: .none),
            text("this is ", with: .bold, .italic),
            text("italic!\n", with: .italic),
            text("A ", with: .h2),
            text("smaller ", with: .h2, .italic),
            text("header", with: .h2, .code),
            text("Some normal text", with: .none),
            text(" and lastly", with: .bold),
            text(" some ", with: .bold, .italic),
            text("italic.\n", with: .italic),
            text("Final words:", with: .h3, .bold, .italic),
            text("Thank ", with: .italic),
            text("you ", with: .bold, .italic),
            text("and ", with: .italic),
            text("goodbye!", with: .bold)
        )
        // WHEN
        let result = sut.parse(attributedString: input)
        // THEN
        let expectation =
        """
        # This is a header!
        This is normal text. **This text is in bold.** Here is some more normal text but _**this is** italic!_
        ## A _smaller_ `header`
        Some normal text **and lastly _some_** _italic._
        ### **_Final words:_**
        _Thank **you** and_ **goodbye!**
        """
        
        XCTAssertEqual(expectation, result)
    }
    
}

private extension NSAttributedStringKey {
    static let markdown = NSAttributedStringKey(rawValue: MarkdownIDAttributeName)
}

private extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
