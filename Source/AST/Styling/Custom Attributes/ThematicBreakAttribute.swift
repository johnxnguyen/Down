//
//  ThematicBreaAttributek.swift
//  Down
//
//  Created by John Nguyen on 02.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS) && !os(Linux)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public class ThematicBreakAttribute : NSObject, NSCoding {
    var thickness: CGFloat
    var color: DownColor
    
    init(thickness: CGFloat, color: DownColor) {
      self.color = color
      self.thickness = thickness
    }
  
    public func encode(with coder: NSCoder) {
      coder.encode(color, forKey: "color")
      coder.encode(thickness, forKey: "thickness")
    }
  
    public required init?(coder: NSCoder) {
      color = coder.decodeObject(forKey: "color") as? DownColor ?? DownColor()
      thickness = coder.decodeObject(forKey: "thickness") as? CGFloat ?? 0.0
    }
}

extension NSAttributedString.Key {
    
    static let thematicBreak = NSAttributedString.Key(rawValue: "thematicBreak")
}

#endif
