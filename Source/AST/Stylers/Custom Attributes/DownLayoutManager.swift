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
        drawCustomAttriibutes(forGlyphRange: glyphsToShow, at: origin)
    }

    private func drawCustomAttriibutes(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        let characterRange = self.characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)
        drawThematicBreakIfNeeded(in: characterRange, at: origin)
        drawQuoteStripeIfNeeded(in: characterRange, at: origin)
    }

    private func drawThematicBreakIfNeeded(in characterRange: NSRange, at origin: CGPoint) {
        textStorage?.enumerateAttribute(.thematicBreak, in: characterRange, options: []) { value, range, _ in
            guard let attr = value as? ThematicBreakAttribute else { return }
            let firstGlyphIndex = glyphIndexForCharacter(at: range.lowerBound)
            let lineRect = lineFragmentRect(forGlyphAt: firstGlyphIndex, effectiveRange: nil)
            let adjustedLineRect = lineRect.translatedTo(point: origin)

            drawThematicBreak(in: adjustedLineRect, attr: attr)
        }
    }

    private func drawQuoteStripeIfNeeded(in characterRange: NSRange, at origin: CGPoint) {
        textStorage?.enumerateAttribute(.quoteStripe, in: characterRange, options: []) { value, range, _ in
            guard let attr = value as? QuoteStripeAttribute else { return }
            guard let context = UIGraphicsGetCurrentContext() else { return }

            UIGraphicsPushContext(context)
            defer { UIGraphicsPopContext() }

            context.setFillColor(attr.color.cgColor)

            let glyphRangeOfQuote = self.glyphRange(forCharacterRange: range, actualCharacterRange: nil)

            enumerateLineFragments(forGlyphRange: glyphRangeOfQuote) { rect, _, textContainer, _, _ in
                for location in attr.locations {
                    let padding: CGFloat = textContainer.lineFragmentPadding
                    let offset = location + padding

                    let stripeOrigin = CGPoint(x: rect.minX + offset, y: rect.minY)
                    let stripeSize = CGSize(width: attr.thickness, height: rect.height)

                    let stripeRect = CGRect(origin: stripeOrigin, size: stripeSize)
                    let adjustedStripeRect = stripeRect.translatedTo(point: origin)

                    context.fill(adjustedStripeRect)
                }
            }
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

    // TODO: For debug purposes
    private func drawLineFragments(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint, usedPortionsOnly: Bool = false) {
        enumerateLineFragments(forGlyphRange: glyphsToShow) { rect, usedRect, textContainer, glyphRange, _ in
            let (rectToDraw, color) = usedPortionsOnly ? (usedRect, UIColor.blue) : (rect, UIColor.red)
            let adjustedRect = rectToDraw.translatedTo(point: origin)
            self.drawRect(adjustedRect, color: color.cgColor)
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


extension CGRect {

    func translatedTo(point: CGPoint) -> CGRect {
        return CGRect(x: origin.x + point.x, y: origin.y + point.y, width: width, height: height)
    }
}

#endif
