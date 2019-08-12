//
//  CGPoint+Translate.swift
//  Down
//
//  Created by John Nguyen on 12.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

extension CGPoint {

    // TODO: test
    func translated(by point: CGPoint) -> CGPoint {
        return CGPoint(x: x + point.x, y: y + point.y)
    }
}

#endif
