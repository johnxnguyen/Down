//
//  CodeBlockOptions.swift
//  Down
//
//  Created by John Nguyen on 12.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if !os(watchOS)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public struct CodeBlockOptions {

    public var containerInset: CGFloat = 8
}

#endif
