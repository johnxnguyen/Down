//
//  CGRect+Helpers.swift
//  Down
//
//  Created by John Nguyen on 12.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

// TODO: test
extension CGRect {

    init(_ minX: CGFloat, _ minY: CGFloat, _ maxX: CGFloat, _ maxY: CGFloat) {
        self.init(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }

    func translated(by point: CGPoint) -> CGRect {
        return CGRect(origin: origin.translated(by: point), size: size)
    }
}

#endif
