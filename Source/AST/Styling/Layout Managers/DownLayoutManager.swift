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
        guard
            let context = UIGraphicsGetCurrentContext(),
            let textStorage = textStorage
            else { return }

        UIGraphicsPushContext(context)
        defer { UIGraphicsPopContext() }

        let allQuoteGlyphRanges = quoteGlyphRanges(in: textStorage, inCharacterRange: characterRange)

        textStorage.enumerateAttributes(for: .quoteStripe, in: characterRange) { (attr: QuoteStripeAttribute, quoteRange) in

            context.setFillColor(attr.color.cgColor)

            let currentQuoteGlyphRange = self.glyphRange(forCharacterRange: quoteRange, actualCharacterRange: nil)
            
            enumerateLineFragments(forGlyphRange: currentQuoteGlyphRange) { lineRect, lineUsedRect, container, lineGlyphRange, _ in

                let isLineStartOfQuote = allQuoteGlyphRanges.contains {
                    lineGlyphRange.overlapsStart(of: $0)
                }

                let isLineEndOfQuote = allQuoteGlyphRanges.contains {
                    lineGlyphRange.overlapsEnd(of: $0)

                }

                let minX = lineRect.minX + container.lineFragmentPadding
                let minY = isLineStartOfQuote ? lineUsedRect.minY : lineRect.minY
                let maxY = isLineEndOfQuote ? lineUsedRect.maxY : lineRect.maxY

                let candidateStripeOrigin = CGPoint(x: minX, y: minY)
                let stripeSize = CGSize(width: attr.thickness, height: maxY - minY)

                let stripeOrigins = attr.locations.map {
                    CGPoint(x: $0, y: 0)
                        .translated(by: candidateStripeOrigin)
                        .translated(by: origin)
                }

                stripeOrigins.forEach {
                    let stripeRect = CGRect(origin: $0, size: stripeSize)
                    context.fill(stripeRect)
                }
            }
        }
    }

    private func quoteGlyphRanges(in storage: NSTextStorage, inCharacterRange range: NSRange) -> [NSRange] {
        return storage
            .ranges(of: .quoteStripe, in: range)
            .map { self.glyphRange(forCharacterRange: $0, actualCharacterRange: nil) }
            .merged()
    }
}


extension CGRect {

    func translated(by point: CGPoint) -> CGRect {
        return CGRect(origin: origin.translated(by: point), size: size)
    }
}

extension CGPoint {

    func translated(by point: CGPoint) -> CGPoint {
        return CGPoint(x: x + point.x, y: y + point.y)
    }
}

private extension NSRange {

    func overlapsStart(of range: NSRange) -> Bool {
        return lowerBound <= range.lowerBound && upperBound > range.lowerBound
    }

    func overlapsEnd(of range: NSRange) -> Bool {
        return lowerBound < range.upperBound && upperBound >= range.upperBound
    }
}

private extension Array where Element == NSRange {


    // TODO: Should this swallow contained ranges? And should it merge overlapping ranges?
    func merged() -> [Element] {
        // Sort by lowerbound
        let sorted = self.sorted { $0.lowerBound <= $1.lowerBound }

        let result = sorted.reduce(into: [NSRange]()) { acc, next in
            guard let last = acc.popLast() else {
                acc.append(next)
                return
            }

            guard last.upperBound == next.lowerBound else {
                acc.append(contentsOf: [last, next])
                return
            }

            acc.append(NSRange(location: last.lowerBound, length: next.upperBound - last.lowerBound))
        }

        return result
    }
}

#endif
