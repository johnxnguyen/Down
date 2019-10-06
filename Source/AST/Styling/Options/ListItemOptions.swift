//
//  ListItemOptions.swift
//  Down
//
//  Created by John Nguyen on 04.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public struct ListItemOptions {

    public var maxPrefixDigits: UInt = 2
    public var spacingAfterPrefix: CGFloat = 8
    public var spacingAbove: CGFloat = 4
    public var spacingBelow: CGFloat = 8
}

#endif
