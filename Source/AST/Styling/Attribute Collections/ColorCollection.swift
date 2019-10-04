//
//  ColorCollection.swift
//  Down
//
//  Created by John Nguyen on 27.07.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS)

#if canImport(UIKit)

import UIKit
public typealias DownColor = UIColor

#elseif canImport(AppKit)

import AppKit
public typealias DownColor = NSColor

#endif

public protocol ColorCollection {

    var heading1: DownColor { get }
    var heading2: DownColor { get }
    var heading3: DownColor { get }
    var body: DownColor { get }
    var code: DownColor { get }
    var link: DownColor { get }
    var quote: DownColor { get }
    var quoteStripe: DownColor { get }
    var thematicBreak: DownColor { get }
    var listItemPrefix: DownColor { get }
    var codeBlockBackground: DownColor { get }
}

public struct StaticColorCollection: ColorCollection {

    public var heading1 = DownColor.black
    public var heading2 = DownColor.black
    public var heading3 = DownColor.black
    public var body = DownColor.black
    public var code = DownColor.black
    public var link = DownColor.systemBlue
    public var quote = DownColor.darkGray
    public var quoteStripe = DownColor.darkGray
    public var thematicBreak = DownColor(white: 0.9, alpha: 1)
    public var listItemPrefix = DownColor.lightGray
    public var codeBlockBackground = DownColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
}

#endif
