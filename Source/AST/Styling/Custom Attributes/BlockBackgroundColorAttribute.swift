//
//  BlockBackgroundColorAttribute.swift
//  Down
//
//  Created by John Nguyen on 11.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

struct BlockBackgroundColorAttribute {

    var color: DownColor
    var inset: CGFloat
}

extension NSAttributedString.Key {

    static let blockBackgroundColor = NSAttributedString.Key("blockBackgroundColor")
}
