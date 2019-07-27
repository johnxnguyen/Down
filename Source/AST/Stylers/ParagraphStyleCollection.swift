//
//  ParagraphStyleCollection.swift
//  Down
//
//  Created by John Nguyen on 27.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

public struct ParagraphStyleCollection: AttributeCollection {

    public typealias Attribute = NSParagraphStyle

    public var heading1: NSParagraphStyle
    public var heading2: NSParagraphStyle
    public var heading3: NSParagraphStyle
    public var body: NSParagraphStyle
    public var quote: NSParagraphStyle
    public var code: NSParagraphStyle

    public init() {
        let headingStyle = NSMutableParagraphStyle()
        headingStyle.paragraphSpacing = 8

        let bodyStyle = NSMutableParagraphStyle()
        bodyStyle.paragraphSpacingBefore = 8
        bodyStyle.paragraphSpacing = 8

        heading1 = headingStyle
        heading2 = headingStyle
        heading3 = headingStyle
        body = bodyStyle
        quote = bodyStyle
        code = NSParagraphStyle()
    }
}

#endif
