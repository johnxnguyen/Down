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
        drawCustomBackgrounds(forGlyphRange: glyphsToShow, at: origin)
        super.drawGlyphs(forGlyphRange: glyphsToShow, at: origin)
        drawCustomAttriibutes(forGlyphRange: glyphsToShow, at: origin)
    }

    private func drawCustomBackgrounds(forGlyphRange glyphsToShow: NSRange,  at origin: CGPoint) {
        guard
            let context = UIGraphicsGetCurrentContext(),
            let textStorage = textStorage
            else { return }

        UIGraphicsPushContext(context)
        defer { UIGraphicsPopContext() }

        let characterRange = self.characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)

        textStorage.enumerateAttributes(for: .blockBackgroundColor, in: characterRange) { (attr: BlockBackgroundColorAttribute, blockRange) in

            let inset = attr.inset

            context.setFillColor(attr.color.cgColor)

            let allBlockColorRanges = glyphRanges(for: .blockBackgroundColor, in: textStorage, inCharacterRange: blockRange)
            let blockColorGlyphRange = glyphRange(forCharacterRange: blockRange, actualCharacterRange: nil)

            enumerateLineFragments(forGlyphRange: blockColorGlyphRange) { lineRect, lineUsedRect, container, lineGlyphRange, _ in

                let isLineStartOfBlock = allBlockColorRanges.contains {
                    lineGlyphRange.overlapsStart(of: $0)
                }

                let isLineEndOfBlock = allBlockColorRanges.contains {
                    lineGlyphRange.overlapsEnd(of: $0)
                }

                let minX = lineUsedRect.minX + container.lineFragmentPadding - inset
                let maxX = lineRect.maxX
                let minY = isLineStartOfBlock ? lineUsedRect.minY - inset : lineRect.minY
                let maxY = isLineEndOfBlock ? lineUsedRect.maxY + inset : lineUsedRect.maxY
                let blockRect = CGRect(minX, minY, maxX, maxY).translated(by: origin)

                context.fill(blockRect)
            }
        }
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

        textStorage?.enumerateAttributes(for: .quoteStripe, in: characterRange) { (attr: QuoteStripeAttribute, quoteRange) in
            context.setFillColor(attr.color.cgColor)

            let glyphRangeOfQuote = self.glyphRange(forCharacterRange: quoteRange, actualCharacterRange: nil)

            enumerateLineFragments(forGlyphRange: glyphRangeOfQuote) { lineRect, _, container, _, _ in
                let locations = attr.locations.map {
                    CGPoint(x: $0 + container.lineFragmentPadding, y: 0)
                        .translated(by: lineRect.origin)
                        .translated(by: origin)
                }

                let stripeSize = CGSize(width: attr.thickness, height: lineRect.height)
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

    private func glyphRanges(for key: NSAttributedString.Key, in storage: NSTextStorage, inCharacterRange range: NSRange) -> [NSRange] {
        return storage
            .ranges(of: key, in: range)
            .map { self.glyphRange(forCharacterRange: $0, actualCharacterRange: nil) }
            .mergeNeighbors()
    }
}

extension CGRect {

    init(_ minX: CGFloat, _ minY: CGFloat, _ maxX: CGFloat, _ maxY: CGFloat) {
        self.init(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }

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

    func mergeNeighbors() -> [Element] {
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
