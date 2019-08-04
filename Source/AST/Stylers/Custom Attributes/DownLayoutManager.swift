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

    // TODO: Get this from the text view
    // TODO: How do we know which text container this is for?
    public var insets: UIEdgeInsets = .init(top: 8, left: 0, bottom: 0, right: 0)

    override public func drawGlyphs(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawGlyphs(forGlyphRange: glyphsToShow, at: origin)

        let characterRange = self.characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)
        drawThematicBreakIfNeeded(in: characterRange)
        drawQuoteStripeIfNeeded(in: characterRange)
    }

    private func drawThematicBreakIfNeeded(in characterRange: NSRange) {
        textStorage?.enumerateAttribute(.thematicBreak, in: characterRange, options: []) { value, range, _ in
            guard let attr = value as? ThematicBreakAttribute else { return }
            let firstGlyphIndex = glyphIndexForCharacter(at: range.lowerBound)
            let lineRect = lineFragmentRect(forGlyphAt: firstGlyphIndex, effectiveRange: nil)
            let adjustedLineRect = lineRect.translatedTo(point: .init(x: insets.left, y: insets.top))

            drawThematicBreak(in: adjustedLineRect, attr: attr)
        }
    }

    private func drawQuoteStripeIfNeeded(in characterRange: NSRange) {
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

                    let origin = CGPoint(x: rect.minX + offset, y: rect.minY)
                    let size = CGSize(width: attr.thickness, height: rect.height)

                    let stripeRect = CGRect(origin: origin, size: size)
                    let adjustedStripeRect = stripeRect.translatedTo(point: .init(x: self.insets.left, y: self.insets.top))

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
    private func drawLineFragments(forGlyphRange glyphsToShow: NSRange, usedPortionsOnly: Bool = false) {
        enumerateLineFragments(forGlyphRange: glyphsToShow) { rect, usedRect, textContainer, glyphRange, _ in
            let (rectToDraw, color) = usedPortionsOnly ? (usedRect, UIColor.blue) : (rect, UIColor.red)
            let adjustedRect = rectToDraw.shiftedVertically(by: self.insets.top)
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

    func shiftedVertically(by points: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y + points, width: width, height: height)
    }

    func translatedTo(point: CGPoint) -> CGRect {
        return CGRect(x: origin.x + point.x, y: origin.y + point.y, width: width, height: height)
    }
}

#endif
