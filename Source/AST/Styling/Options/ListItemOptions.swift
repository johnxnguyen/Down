//
//  ListItemOptions.swift
//  Down
//
//  Created by John Nguyen on 04.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

public struct ListItemOptions {

    public var maxPrefixDigits: UInt
    public var spacingAfterPrefix: CGFloat
    public var spacingAbove: CGFloat
    public var spacingBelow: CGFloat
}

public extension ListItemOptions {

    init() {
        maxPrefixDigits = 2
        spacingAfterPrefix = 8
        spacingAbove = 4
        spacingBelow = 8
    }
}

#endif
