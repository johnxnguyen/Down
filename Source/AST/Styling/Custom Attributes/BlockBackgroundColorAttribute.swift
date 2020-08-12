//
//  BlockBackgroundColorAttribute.swift
//  Down
//
//  Created by John Nguyen on 11.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS) && !os(Linux)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public struct BlockBackgroundColorAttribute {

    public var color: DownColor
    public var inset: CGFloat

    public init(color: DownColor, inset: CGFloat) {
        self.color = color
        self.inset = inset
    }
}

extension NSAttributedString.Key {

    public static let blockBackgroundColor = NSAttributedString.Key("blockBackgroundColor")
}

#endif
