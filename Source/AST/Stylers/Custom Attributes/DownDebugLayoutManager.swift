//
//  DownDebugLayoutManager.swift
//  Down
//
//  Created by John Nguyen on 06.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

class DownDebugLayoutManager: DownLayoutManager {

    override func drawGlyphs(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawGlyphs(forGlyphRange: glyphsToShow, at: origin)
        drawLineFragments(forGlyphRange: glyphsToShow, at: origin)
    }

    private func drawLineFragments(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        enumerateLineFragments(forGlyphRange: glyphsToShow) { rect, usedRect, textContainer, glyphRange, _ in
            [(usedRect, UIColor.blue), (rect, UIColor.red)].forEach { rectToDraw, color in
                let adjustedRect = rectToDraw.translated(by: origin)
                self.drawRect(adjustedRect, color: color.cgColor)
            }
        }
    }

    private func drawRect(_ rect: CGRect, color: CGColor) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        UIGraphicsPushContext(context)
        context.setStrokeColor(color)
        context.stroke(rect)
        UIGraphicsPopContext()
    }
}

#endif
