//
//  CGPoint+Translate.swift
//  Down
//
//  Created by John Nguyen on 12.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

extension CGPoint {

    func translated(by point: CGPoint) -> CGPoint {
        return CGPoint(x: x + point.x, y: y + point.y)
    }
}
