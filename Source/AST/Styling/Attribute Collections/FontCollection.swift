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

public struct FontCollection {

    public var heading1: UIFont
    public var heading2: UIFont
    public var heading3: UIFont
    public var body: UIFont
    public var code: UIFont
    public var listItemPrefix: UIFont

    public init() {
        heading1 = .systemFont(ofSize: 28)
        heading2 = .systemFont(ofSize: 24)
        heading3 = .systemFont(ofSize: 20)

        let normal = UIFont.systemFont(ofSize: 17)

        body = normal

        if #available(iOS 12, *) {
            code = .monospacedSystemFont(ofSize: normal.pointSize, weight: .regular)
        } else {
            code = UIFont(name: "menlo", size: normal.pointSize) ?? normal
        }

        listItemPrefix = .monospacedDigitSystemFont(ofSize: body.pointSize, weight: .regular)
    }
}

public extension FontCollection {

    static let dynamicFonts: FontCollection = {

        var fonts = FontCollection()
        fonts.heading1 = .preferredFont(forTextStyle: .title1)
        fonts.heading2 = .preferredFont(forTextStyle: .title2)
        fonts.heading3 = .preferredFont(forTextStyle: .title3)
        fonts.body = .preferredFont(forTextStyle: .body)
        fonts.listItemPrefix = .monospacedDigitSystemFont(ofSize: fonts.body.pointSize, weight: .regular)

        // TODO: Clean this
        if #available(iOS 12, *) {
            fonts.code = .monospacedSystemFont(ofSize: fonts.body.pointSize, weight: .regular)
        }
        else if let menlo = UIFont(name: "menlo", size: fonts.body.pointSize) {
            if #available(iOS 11, *) {
                fonts.code = UIFontMetrics(forTextStyle: .body).scaledFont(for: menlo)
            }
            else {
                fonts.code = menlo
            }
        }
        else {
            fonts.code = fonts.body
        }

        return fonts
    }()
}


#endif
