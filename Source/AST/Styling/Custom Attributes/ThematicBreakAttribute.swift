//
//  ThematicBreaAttributek.swift
//  Down
//
//  Created by John Nguyen on 02.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

struct ThematicBreakAttribute {

    var thickness: CGFloat
    var color: DownColor
}

extension NSAttributedString.Key {
    
    static let thematicBreak = NSAttributedString.Key(rawValue: "thematicBreak")
}

#endif
