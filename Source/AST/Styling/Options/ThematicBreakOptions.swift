//
//  ThematicBreakOptions.swift
//  Down
//
//  Created by John Nguyen on 04.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

public struct ThematicBreakOptions {

    public var thickness: CGFloat
    public var indentation: CGFloat

    public init(thickness: CGFloat, indentation: CGFloat)  {
        self.thickness = thickness
        self.indentation = indentation
    }
}

#endif
