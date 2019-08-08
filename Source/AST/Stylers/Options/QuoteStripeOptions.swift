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
    public var color: UIColor
    public var thickness: CGFloat
    public var spacingAfter: CGFloat

    public init(color: UIColor, thickness: CGFloat = 4, spacingAfter: CGFloat = 8) {
        self.color = color
        self.thickness = thickness
        self.spacingAfter = spacingAfter
    }
}

#endif
