//
//  BlockBackgroundColorAttribute.swift
//  Down
//
//  Created by John Nguyen on 11.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS) && !os(Linux)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public class BlockBackgroundColorAttribute : NSObject, NSCoding {
    var color: DownColor
    var inset: CGFloat
  
    init(color: DownColor, inset: CGFloat) {
        self.color = color
        self.inset = inset
    }
  
    public func encode(with coder: NSCoder) {
        coder.encode(color, forKey: "color")
        coder.encode(inset, forKey: "inset")
    }
    
    public required init?(coder: NSCoder) {
        color = coder.decodeObject(forKey: "color") as? DownColor ?? DownColor()
        inset = coder.decodeObject(forKey: "inset") as? CGFloat ?? 0.0
    }
}

extension NSAttributedString.Key {

    static let blockBackgroundColor = NSAttributedString.Key("blockBackgroundColor")
}

#endif
