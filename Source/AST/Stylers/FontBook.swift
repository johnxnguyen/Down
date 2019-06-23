//
//  FontBook.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

protocol FontBook {
    
    var heading1: UIFont { get }
    var heading2: UIFont { get }
    var heading3: UIFont { get }
    var body: UIFont { get }
    var code: UIFont { get }
}

// TODO: Documentation -> When using dynamic fonts, we should make sure the text view property
// `adjustsFontForContentSizeCategory` is actually false. Instead override `traitCollectionDidChange()` to
// manually reload the content.

struct DynamicFonts: FontBook {

    let heading1: UIFont
    let heading2: UIFont
    let heading3: UIFont
    let body: UIFont
    let code: UIFont

    init() {
        heading1 = .preferredFont(forTextStyle: .title1)
        heading2 = .preferredFont(forTextStyle: .title2)
        heading3 = .preferredFont(forTextStyle: .title3)
        body = .preferredFont(forTextStyle: .body)

        if let menlo = UIFont(name: "menlo", size: body.pointSize) {
            if #available(iOSApplicationExtension 11.0, *) {
                code = UIFontMetrics(forTextStyle: .body).scaledFont(for: menlo)
            } else {
                code = menlo
            }
        } else {
            code = .preferredFont(forTextStyle: .body)
        }
    }
}

#endif
