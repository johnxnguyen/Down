//
//  CGRect+Helpers.swift
//  Down
//
//  Created by John Nguyen on 12.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(Linux)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

extension CGRect {

    init(minX: CGFloat, minY: CGFloat, maxX: CGFloat, maxY: CGFloat) {
        self.init(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }

    func translated(by point: CGPoint) -> CGRect {
        return CGRect(origin: origin.translated(by: point), size: size)
    }

}

#endif
