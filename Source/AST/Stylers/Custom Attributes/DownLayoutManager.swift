//
//  DownLayoutManager.swift
//  Down
//
//  Created by John Nguyen on 02.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

public class DownLayoutManager: NSLayoutManager {

    override public func drawGlyphs(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawGlyphs(forGlyphRange: glyphsToShow, at: origin)

        let characterRange = self.characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)
        drawThematicBreakIfNeeded(in: characterRange)
    }

    private func drawThematicBreakIfNeeded(in characterRange: NSRange) {
        textStorage?.enumerateAttribute(.thematicBreak, in: characterRange, options: []) { value, range, _ in
            guard let attr = value as? ThematicBreakAttribute else { return }
            let glyphIndex = glyphIndexForCharacter(at: range.lowerBound)
            let lineRect = lineFragmentRect(forGlyphAt: glyphIndex, effectiveRange: nil)
            drawThematicBreak(in: lineRect, attr: attr)
        }
    }

    private func drawThematicBreak(in lineRect: CGRect, attr: ThematicBreakAttribute) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(attr.color.cgColor)
        context.setLineWidth(attr.thickness)
        context.move(to: CGPoint(x: lineRect.minX, y: lineRect.midY))
        context.addLine(to: CGPoint(x: lineRect.maxX, y: lineRect.midY))
        context.strokePath()
    }
}

#endif
