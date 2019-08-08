//
//  FontCollection.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit


// TODO: Documentation -> When using dynamic fonts, we should make sure the text view property
// `adjustsFontForContentSizeCategory` is actually false. Instead override `traitCollectionDidChange()` to
// manually reload the content.

public struct FontCollection: AttributeCollection {

    public var heading1: UIFont
    public var heading2: UIFont
    public var heading3: UIFont
    public var body: UIFont
    public var quote: UIFont
    public var code: UIFont
    public var listItemPrefix: UIFont
}

public extension FontCollection {

    static let dynamicFonts: FontCollection = {

        let heading1 = UIFont.preferredFont(forTextStyle: .title1)
        let heading2 = UIFont.preferredFont(forTextStyle: .title2)
        let heading3 = UIFont.preferredFont(forTextStyle: .title3)
        let body = UIFont.preferredFont(forTextStyle: .body)
        let quote = body
        var code = body
        let listItemPrefix = UIFont.monospacedDigitSystemFont(ofSize: body.pointSize, weight: .regular)

        // TODO: Clean this
        if #available(iOS 12, *) {
            code = .monospacedSystemFont(ofSize: body.pointSize, weight: .regular)
        }
        else if let menlo = UIFont(name: "menlo", size: body.pointSize) {
            if #available(iOS 11, *) {
                code = UIFontMetrics(forTextStyle: .body).scaledFont(for: menlo)
            }
            else {
                code = menlo
            }
        }

        return FontCollection(heading1: heading1,
                              heading2: heading2,
                              heading3: heading3,
                              body: body,
                              quote: quote,
                              code: code,
                              listItemPrefix: listItemPrefix)
    }()
}


#endif
