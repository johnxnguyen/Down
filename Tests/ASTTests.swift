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

class ASTTests: XCTestCase {
    
    class AppMock: UIApplicationProtocol {
        func canOpenURL(_ url:URL) -> Bool {
            return true
        }
    }
    
    let style = DownStyle()
    
    override func setUp() {
        super.setUp()
        Application.shared = AppMock()
    }
    
    func testThatItDoesNotRenderLinkIfURLIsInvalid() {
        // GIVEN
        let input = "[click me!](someLink)"
        let down = Down(markdownString: input)
        // WHEN
        let result = try? down.toAttributedString(using: style)
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(input, result!.string.trimmingCharacters(in: .whitespacesAndNewlines))
        var range = NSMakeRange(NSNotFound, 0)
        let attrs = result!.attributes(at: 0, effectiveRange: &range)
        XCTAssertEqual(NSMakeRange(0, (input as NSString).length), range)
        XCTAssertNil(attrs[.link])
    }
    
    func testThatItDoesNotRenderLinkIfPlaceholdContainsLink() {
        // GIVEN
        let input = "[www.test.com](www.example.com)"
        let down = Down(markdownString: input)
        // WHEN
        let result = try? down.toAttributedString(using: style)
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(input, result!.string.trimmingCharacters(in: .whitespacesAndNewlines))
        var range = NSMakeRange(NSNotFound, 0)
        let attrs = result!.attributes(at: 0, effectiveRange: &range)
        XCTAssertEqual(NSMakeRange(0, (input as NSString).length), range)
        XCTAssertNil(attrs[.link])
    }
    
    func testThatItDoesNotRenderInlineOnLinkPlaceholder() {
        // GIVEN
        let input = "[**click** *me* `please`](www.wire.com)"
        let down = Down(markdownString: input)
        // WHEN
        let result = try? down.toAttributedString(using: style)
        // THEN
        let placeholder = "click me please"
        XCTAssertNotNil(result)
        XCTAssertEqual(placeholder, result!.string.trimmingCharacters(in: .whitespacesAndNewlines))
        var range = NSMakeRange(NSNotFound, 0)
        let attrs = result!.attributes(at: 0, effectiveRange: &range)
        XCTAssertEqual(NSMakeRange(0, (placeholder as NSString).length), range)
        XCTAssertNotNil(attrs[.link])
        XCTAssertEqual(style.baseFont, attrs[.font] as? UIFont)
    }
    
}
