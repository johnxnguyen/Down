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
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        UIGraphicsPushContext(context)
        defer { UIGraphicsPopContext() }

        textStorage?.enumerateAttributes(for: .thematicBreak, in: characterRange) { (attr: ThematicBreakAttribute, range) in
            let firstGlyphIndex = glyphIndexForCharacter(at: range.lowerBound)

            let lineRect = lineFragmentRect(forGlyphAt: firstGlyphIndex, effectiveRange: nil)
            let usedRect = lineFragmentUsedRect(forGlyphAt: firstGlyphIndex, effectiveRange: nil)

            let lineStart = usedRect.minX + fragmentPadding(forGlyphAt: firstGlyphIndex)

            let boundingRect = CGRect(x: lineStart, y: lineRect.minY, width: lineRect.width - lineStart, height: lineRect.height)
            let adjustedLineRect = boundingRect.translated(by: origin)

            drawThematicBreak(with: context, in: adjustedLineRect, attr: attr)
        }
    }

    private func fragmentPadding(forGlyphAt glyphIndex: Int) -> CGFloat {
        let textContainer = self.textContainer(forGlyphAt: glyphIndex, effectiveRange: nil)
        return textContainer?.lineFragmentPadding ?? 0
    }

    private func drawThematicBreak(with context: CGContext, in rect: CGRect, attr: ThematicBreakAttribute) {
        context.setStrokeColor(attr.color.cgColor)
        context.setLineWidth(attr.thickness)
        context.move(to: CGPoint(x: rect.minX, y: rect.midY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        context.strokePath()
    }

    private func drawQuoteStripeIfNeeded(in characterRange: NSRange, at origin: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        UIGraphicsPushContext(context)
        defer { UIGraphicsPopContext() }

        textStorage?.enumerateAttributes(for: .quoteStripe, in: characterRange) { (attr: QuoteStripeAttribute, range) in
            context.setFillColor(attr.color.cgColor)

            let glyphRangeOfQuote = self.glyphRange(forCharacterRange: range, actualCharacterRange: nil)

            enumerateLineFragments(forGlyphRange: glyphRangeOfQuote) { rect, _, textContainer, _, _ in
                let stripeSize = CGSize(width: attr.thickness, height: rect.height)
                let offset = CGPoint(x: textContainer.lineFragmentPadding, y: 0)

                let locations = attr.locations.map {
                    CGPoint(x: $0, y: 0)
                        .translated(by: offset)
                        .translated(by: rect.origin)
                        .translated(by: origin)
                }

                self.drawQuoteStripes(with: context, locations: locations, size: stripeSize)
            }
        }
    }

    private func drawQuoteStripes(with context: CGContext, locations: [CGPoint], size: CGSize) {
        locations.forEach {
            let stripeRect = CGRect(origin: $0, size: size)
            context.fill(stripeRect)
        }
    }

    // TODO: For debug purposes
    private func drawLineFragments(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint, usedPortionsOnly: Bool = false) {
        enumerateLineFragments(forGlyphRange: glyphsToShow) { rect, usedRect, textContainer, glyphRange, _ in
            let (rectToDraw, color) = usedPortionsOnly ? (usedRect, UIColor.blue) : (rect, UIColor.red)
            let adjustedRect = rectToDraw.translated(by: origin)
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


private extension CGRect {

    func translated(by point: CGPoint) -> CGRect {
        return CGRect(x: origin.x + point.x, y: origin.y + point.y, width: width, height: height)
    }
}

private extension CGPoint {

    func translated(by point: CGPoint) -> CGPoint {
        return CGPoint(x: x + point.x, y: y + point.y)
    }
}

#endif
