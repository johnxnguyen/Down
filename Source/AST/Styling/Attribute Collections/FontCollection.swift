//
//  FontCollection.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS)

#if canImport(UIKit)

import UIKit
public typealias DownFont = UIFont

#elseif canImport(AppKit)

import AppKit
public typealias DownFont = NSFont

#endif

public protocol FontCollection {

    var heading1: DownFont { get }
    var heading2: DownFont { get }
    var heading3: DownFont { get }
    var body: DownFont { get }
    var code: DownFont { get }
    var listItemPrefix: DownFont { get }
}

public struct StaticFontCollection: FontCollection {

    public var heading1 = DownFont.boldSystemFont(ofSize: 28)
    public var heading2 = DownFont.boldSystemFont(ofSize: 24)
    public var heading3 = DownFont.boldSystemFont(ofSize: 20)
    public var body = DownFont.systemFont(ofSize: 17)
    public var code = DownFont(name: "menlo", size: 17) ?? .systemFont(ofSize: 17)
    public var listItemPrefix = DownFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular)
}

#endif
