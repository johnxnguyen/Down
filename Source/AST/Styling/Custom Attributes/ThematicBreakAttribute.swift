//
//  ThematicBreaAttributek.swift
//  Down
//
//  Created by John Nguyen on 02.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

struct ThematicBreakAttribute {

    var thickness: CGFloat
    var color: UIColor
}

extension NSAttributedString.Key {
    
    static let thematicBreak = NSAttributedString.Key(rawValue: "thematicBreak")
}

#endif
