//
//  CodeBlockOptions.swift
//  Down
//
//  Created by John Nguyen on 12.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS) && !os(Linux)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public struct CodeBlockOptions {

    // MARK: - Properties

    public var containerInset: CGFloat

    // MARK: - Life cycle

    public init(containerInset: CGFloat = 8) {
        self.containerInset = containerInset
    }

}

#endif
