//
//  ColorCollection.swift
//  Down
//
//  Created by John Nguyen on 27.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

public struct ColorCollection {

    public var heading1: UIColor
    public var heading2: UIColor
    public var heading3: UIColor
    public var body: UIColor
    public var code: UIColor
    public var link: UIColor
    public var quote: UIColor
    public var quoteStripe: UIColor
    public var thematicBreak: UIColor
    public var listItemPrefix: UIColor

    public init() {
        heading1 = .black
        heading2 = .black
        heading3 = .black
        body = .black
        code = .lightGray
        link = .systemBlue
        quote = .darkGray
        quoteStripe = .darkGray
        thematicBreak = .lightGray
        listItemPrefix = .lightGray
    }
}

#endif
