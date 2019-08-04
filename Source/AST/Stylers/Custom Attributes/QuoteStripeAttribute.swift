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
    var thickness: CGFloat = 2
    var color: UIColor = .gray
    var spacingAfter: CGFloat = 8
    var locations: [CGFloat] = []
}

extension NSAttributedString.Key {
    static let quoteStripe = NSAttributedString.Key(rawValue: "quoteStripe")
}

#endif
