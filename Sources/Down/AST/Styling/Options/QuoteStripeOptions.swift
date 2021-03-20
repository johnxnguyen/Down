//
//  QuoteStripeOptions.swift
//  Down
//
//  Created by John Nguyen on 04.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(Linux)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public struct QuoteStripeOptions {

    // MARK: - Properties

    public var thickness: CGFloat
    public var spacingAfter: CGFloat

    // MARK: - Life cycle

    public init(thickness: CGFloat = 2, spacingAfter: CGFloat = 8) {
        self.thickness = thickness
        self.spacingAfter = spacingAfter
    }

}

#endif
