//
//  DownDebugLayoutManager.swift
//  Down
//
//  Created by John Nguyen on 06.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

/// A layout manager that draws the line fragments.
///
/// Line fragments are the areas with a document that contain lines of text. There
/// are two types.
///
/// 1. A *line rect* (drawn in red) indicates the maximum rect enclosing the line.
/// This inlcudes not only the textual content, but also the padding (if any) around that text.
/// 2. A *line used rect* (drawn in blue) is the smallest rect enclosing the textual content.
///
/// The visualization of these rects is useful when determining the paragraph styles
/// of a `DownStyler`.
///
/// Insert this into a TextKit stack manually, or use the provided `DownDebugTextView`.
public class DownDebugLayoutManager: DownLayoutManager {

    override public func drawGlyphs(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawGlyphs(forGlyphRange: glyphsToShow, at: origin)
        drawLineFragments(forGlyphRange: glyphsToShow, at: origin)
    }

    private func drawLineFragments(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        enumerateLineFragments(forGlyphRange: glyphsToShow) { rect, usedRect, textContainer, glyphRange, _ in
            [(usedRect, DownColor.blue), (rect, DownColor.red)].forEach { rectToDraw, color in
                let adjustedRect = rectToDraw.translated(by: origin)
                self.drawRect(adjustedRect, color: color.cgColor)
            }
        }
    }

    private func drawRect(_ rect: CGRect, color: CGColor) {
        guard let context = context else { return }
        push(context: context)
        defer { popContext() }

        context.setStrokeColor(color)
        context.stroke(rect)
    }
}

#endif
