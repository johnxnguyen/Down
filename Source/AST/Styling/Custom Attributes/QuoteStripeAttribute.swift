//
//  QuoteStripeAttrbute.swift
//  Down
//
//  Created by John Nguyen on 03.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

struct QuoteStripeAttribute {

    var color: DownColor
    var thickness: CGFloat
    var spacingAfter: CGFloat
    var locations: [CGFloat]

    var layoutWidth: CGFloat {
        return thickness + spacingAfter
    }
}

extension QuoteStripeAttribute {

    init(level: Int, color: DownColor, options: QuoteStripeOptions) {
        self.init(color: color, thickness: options.thickness, spacingAfter: options.spacingAfter, locations: [])
        locations = (0..<level).map { CGFloat($0) * layoutWidth }
    }

    func indented(by indentation: CGFloat) -> QuoteStripeAttribute {
        var copy = self
        copy.locations = locations.map { $0 + indentation }
        return copy
    }
}

extension NSAttributedString.Key {
    
    static let quoteStripe = NSAttributedString.Key(rawValue: "quoteStripe")
}

#endif
