//
//  BlockBackgroundColorAttribute.swift
//  Down
//
//  Created by John Nguyen on 11.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

struct BlockBackgroundColorAttribute {

    var color: UIColor
    var inset: CGFloat
}

extension NSAttributedString.Key {

    static let blockBackgroundColor = NSAttributedString.Key("blockBackgroundColor")
}

#endif
