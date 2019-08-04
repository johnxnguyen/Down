//
//  QuoteStripeAttrbute.swift
//  Down
//
//  Created by John Nguyen on 03.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

struct QuoteStripeAttribute {
    var color: UIColor = .gray
    var thickness: CGFloat = 2
    var spacingAfter: CGFloat = 8
    var locations: [CGFloat] = []

    var layoutWidth: CGFloat {
        return thickness + spacingAfter
    }
}

extension QuoteStripeAttribute {

    init(level: Int, options: QuoteStripeOptions) {
        self.init(color: options.color, thickness: options.thickness, spacingAfter: options.spacingAfter, locations: [])
        locations = (0..<level).map { CGFloat($0) * layoutWidth }
    }
}

extension NSAttributedString.Key {
    static let quoteStripe = NSAttributedString.Key(rawValue: "quoteStripe")
}

#endif
