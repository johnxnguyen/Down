//
//  QuoteStripeAttrbute.swift
//  Down
//
//  Created by John Nguyen on 03.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS) && !os(Linux)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public class QuoteStripeAttribute : NSObject, NSCoding {

    var color: DownColor
    var thickness: CGFloat
    var spacingAfter: CGFloat
    var locations: [CGFloat]

    var layoutWidth: CGFloat {
        return thickness + spacingAfter
    }
    
    public func encode(with coder: NSCoder) {
      coder.encode(color, forKey: "color")
      coder.encode(thickness, forKey: "thickness")
      coder.encode(spacingAfter, forKey: "spacingAfter")
      coder.encode(locations, forKey: "locations")
    }
    
    public required init?(coder: NSCoder) {
      color = coder.decodeObject(forKey: "color") as? DownColor ?? DownColor()
      thickness = coder.decodeObject(forKey: "thickness") as? CGFloat ?? 0.0
      spacingAfter = coder.decodeObject(forKey: "spacingAfter") as? CGFloat ?? 0.0
      locations = coder.decodeObject(forKey: "locations") as? [CGFloat] ?? [CGFloat]()
    }

    init(color: DownColor, thickness: CGFloat, spacingAfter: CGFloat, locations: [CGFloat]) {
      self.color = color
      self.thickness = thickness
      self.spacingAfter = spacingAfter
      self.locations = locations
    }
}

extension QuoteStripeAttribute {

    convenience init(level: Int, color: DownColor, options: QuoteStripeOptions) {
        self.init(color: color, thickness: options.thickness, spacingAfter: options.spacingAfter, locations: [])
        locations = (0..<level).map { CGFloat($0) * layoutWidth }
    }

    func indented(by indentation: CGFloat) -> QuoteStripeAttribute {
        let copy = self
        copy.locations = locations.map { $0 + indentation }
        return copy
    }
}

extension NSAttributedString.Key {
    
    static let quoteStripe = NSAttributedString.Key(rawValue: "quoteStripe")
}

#endif
