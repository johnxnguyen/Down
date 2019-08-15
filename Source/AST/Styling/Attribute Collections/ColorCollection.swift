//
//  ColorCollection.swift
//  Down
//
//  Created by John Nguyen on 27.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import UIKit
public typealias DownColor = UIColor

#elseif canImport(AppKit)

import AppKit
public typealias DownColor = NSColor

#endif

public struct ColorCollection {

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
