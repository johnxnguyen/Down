//
//  QuoteStripeOptions.swift
//  Down
//
//  Created by John Nguyen on 04.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

public struct QuoteStripeOptions {

    public var thickness: CGFloat
    public var spacingAfter: CGFloat
}

public extension QuoteStripeOptions {

    init() {
        thickness = 2
        spacingAfter = 8
    }
}

#endif
