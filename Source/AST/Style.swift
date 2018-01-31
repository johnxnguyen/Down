////
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation
import UIKit

// TODO: check that code font is actually rendering
// what happens with code in header?

/// This OptionSet describes the Markdown units and contains useful helper
/// methods to determine deeper information regarding a type of Markdown.
///
private struct Markdown: OptionSet, Hashable {
    
    public let rawValue: Int
    
    public var hashValue: Int {
        return self.rawValue
    }
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    // atomic options
    
    public static let none             = Markdown(rawValue: 0)
    public static let header           = Markdown(rawValue: 1 << 0)
    public static let bold             = Markdown(rawValue: 1 << 1)
    public static let italic           = Markdown(rawValue: 1 << 2)
    public static let code             = Markdown(rawValue: 1 << 3)
    public static let list             = Markdown(rawValue: 1 << 4)
    
}

private extension NSAttributedStringKey {
    static let markdown = NSAttributedStringKey.init(rawValue: "markdown")
}

public struct Style {
    
    public static var `default`: Style { return Style() }
    
    typealias Attributes = [NSAttributedStringKey : Any]
    
    // base attributes - these will be used for normal text and will be manipulated
    // for bold, italic and code etc.
    
    // change this to system font size
    public var baseFont = UIFont.systemFont(ofSize: 17)
    public var baseFontColor = UIColor.black
    public var baseParagraphStyle = NSParagraphStyle.default.with(topSpacing: 8, bottomSpacing: 8)
    
    // bold attributes
    public var boldColor: UIColor?
    
    // italic attributes
    public var italicColor: UIColor?
    
    // code attributes
    public var codeColor: UIColor? = UIColor.darkGray
    
    // header attributes
    public var h1Color: UIColor? = #colorLiteral(red: 0.9529746175, green: 0.3621142805, blue: 0.3340556622, alpha: 1)
    public var h1Size: CGFloat = 27
    
    public var h2Color: UIColor? = #colorLiteral(red: 0.9529746175, green: 0.3621142805, blue: 0.3340556622, alpha: 1)
    public var h2Size: CGFloat = 24
    
    public var h3Color: UIColor? = #colorLiteral(red: 0.9529746175, green: 0.3621142805, blue: 0.3340556622, alpha: 1)
    public var h3Size: CGFloat = 20
    
    // quote attributes
    public var quoteColor: UIColor? = .gray
    public var quoteParagraphStyle: NSParagraphStyle? = NSParagraphStyle.default.indentedBy(points: 16)
    
    // list attributes
    // TODO: list indentation property
    public var listParagraphStyle = NSParagraphStyle.default.with(tabStopOffset: 16).indentedBy(points: 16)
    
    var defaultAttributes: Attributes {
        return [.font: baseFont,
                .foregroundColor: baseFontColor,
                .paragraphStyle: baseParagraphStyle,
        ]
    }
    
    var boldAttributes: Attributes {
        return [.foregroundColor: boldColor ?? baseFontColor]
    }
    
    var italicAttributes: Attributes {
        return [.foregroundColor: italicColor ?? baseFontColor]
    }
    
    var codeAttributes: Attributes {
        return [.font: baseFont.monospace,
                .foregroundColor: codeColor ?? baseFontColor,
        ]
    }
    
    var quoteAttributes: Attributes {
        return [.foregroundColor: quoteColor ?? baseFontColor,
                .paragraphStyle: quoteParagraphStyle ?? baseParagraphStyle,
        ]
    }
    
    var listAttributes: Attributes {
        return [.markdown: Markdown.list,
                .paragraphStyle: listParagraphStyle,
        ]
    }
    
    var h1Attributes: Attributes {
        return [.foregroundColor: h1Color ?? baseFontColor]
    }
    
    var h2Attributes: Attributes {
        return [.foregroundColor: h2Color ?? baseFontColor]
    }
    
    var h3Attributes: Attributes {
        return [.foregroundColor: h3Color ?? baseFontColor]
    }
    
    func headerSize(for level: Int) -> CGFloat {
        switch level {
        case 1:  return h1Size
        case 2:  return h2Size
        default: return h3Size
        }
    }
    
    func attributes(for renderable: Renderable) -> Attributes? {
        if renderable is Block  { return attributes(for: renderable as! Block) }
        if renderable is Inline { return attributes(for: renderable as! Inline) }
        return nil
    }
    
    private func attributes(for block: Block) -> Attributes? {
        switch block {
        case .blockQuote(_):
            return quoteAttributes
            
        case .list(_, _):
            return listAttributes
            
        case .listItem(_, _):
            return nil
            
        case .codeBlock(_), .htmlBlock(_):
            return codeAttributes
            
        case .customBlock(_):
            return defaultAttributes
            
        case .heading(_, let level):
            switch level {
            case 1:  return h1Attributes
            case 2:  return h2Attributes
            default: return h3Attributes
            }
            
        case .document(_), .paragraph(_), .thematicBreak:
            return nil
        }
    }
    
    private func attributes(for inline: Inline) -> Attributes? {
        switch inline {
        case .text(_), .custom(_):
            return defaultAttributes
            
        case .softBreak, .lineBreak:
            return nil
            
        case .code(_), .html(_):
            return codeAttributes
            
        case .emphasis(_):
            return italicAttributes
            
        case .strong(_):
            return boldAttributes
            
        case .link(_), .image(_):
            return nil
        }
    }
    
}

extension NSMutableAttributedString {
    
    func addAttributes(_ attrs: Style.Attributes?) {
        guard let attrs = attrs else { return }
        addAttributes(attrs, range: wholeRange)
    }
    
    func deppAddItalic() {
        var fonts = [(font: UIFont, range: NSRange)]()
        enumerateAttribute(.font, in: wholeRange, options: []) { val, range, _ in
            guard let font = val as? UIFont else { return }
            fonts.append((font, range))
        }
        
        for (font, range) in fonts {
            addAttributes([.font: font.italic], range: range)
        }
    }
    
    func deepAddBold() {
        var fonts = [(font: UIFont, range: NSRange)]()
        enumerateAttribute(.font, in: wholeRange, options: []) { val, range, _ in
            guard let font = val as? UIFont else { return }
            fonts.append((font, range))
        }
        
        for (font, range) in fonts {
            addAttribute(.font, value: font.bold, range: range)
        }
    }
    
    func deepAddHeader(with size: CGFloat) {
        var fonts = [(font: UIFont, range: NSRange)]()
        enumerateAttribute(.font, in: wholeRange, options: []) { val, range, _ in
            guard let font = val as? UIFont else { return }
            fonts.append((font, range))
        }
        
        for (font, range) in fonts {
            // need to change size before adding bold, because o/w if font
            // contains italics beforehand, it gets removed.
            addAttribute(.font, value: font.withSize(size).bold, range: range)
        }
    }
    
    // FIXME: this assumes there is already a paragraph style.
    //    func deepIndentBy(points: CGFloat) {
    //        var paragraphStyles = [(style: NSParagraphStyle, range: NSRange)]()
    //        enumerateAttribute(.paragraphStyle, in: wholeRange, options: []) { val, range, _ in
    //            guard let style = val as? NSParagraphStyle else { return }
    //            paragraphStyles.append((style, range))
    //        }
    //
    //        for (style, range) in paragraphStyles {
    //            addAttribute(.paragraphStyle, value: style.indentedBy(points: points), range: range)
    //        }
    //    }
    
}

extension NSParagraphStyle {
    
    func with(topSpacing: CGFloat, bottomSpacing: CGFloat) -> NSParagraphStyle {
        let copy = mutableCopy() as! NSMutableParagraphStyle
        copy.paragraphSpacingBefore = topSpacing
        copy.paragraphSpacing = bottomSpacing
        return copy as NSParagraphStyle
    }
    
    /// Indents the current paragraph style by the given number of points.
    func indentedBy(points: CGFloat) -> NSParagraphStyle {
        let copy = mutableCopy() as! NSMutableParagraphStyle
        copy.firstLineHeadIndent += points
        copy.headIndent += points
        // FIXME: could be better
        copy.tabStops = copy.tabStops.map {
            NSTextTab(textAlignment: .left, location: $0.location + points, options: [:])
        }
        
        return copy as NSParagraphStyle
    }
    
    /// Shifts the tabstop offset
    func with(tabStopOffset offset: CGFloat) -> NSParagraphStyle {
        let copy = mutableCopy() as! NSMutableParagraphStyle
        let tabOffset = copy.headIndent + offset
        copy.headIndent = tabOffset
        copy.tabStops = [NSTextTab(textAlignment: .left, location: tabOffset, options: [:])]
        return copy as NSParagraphStyle
    }
}


// TODO: check whether just adding traits works for all fonts?

extension UIFont {
    
    // MARK: - Trait Querying
    
    var isBold: Bool {
        return contains(.traitBold)
    }
    
    var isItalic: Bool {
        return contains(.traitItalic)
    }
    
    var isMonospace: Bool {
        return contains(.traitMonoSpace)
    }
    
    private func contains(_ trait: UIFontDescriptorSymbolicTraits) -> Bool {
        return fontDescriptor.symbolicTraits.contains(trait)
    }
    
    // MARK: - Set Traits
    
    var bold: UIFont {
        return self.with(.traitBold)
    }
    
    var italic: UIFont {
        return self.with(.traitItalic)
    }
    
    var monospace: UIFont {
        return self.with(.traitMonoSpace)
    }
    
    /// Returns a copy of the font with the added symbolic trait.
    private func with(_ trait: UIFontDescriptorSymbolicTraits) -> UIFont {
        guard !contains(trait) else { return self }
        var traits = fontDescriptor.symbolicTraits
        traits.insert(trait)
        // FIXME: perhaps no good!
        guard let newDescriptor = fontDescriptor.withSymbolicTraits(traits) else { return self }
        // size 0 means the size remains the same as before
        return UIFont(descriptor: newDescriptor, size: 0)
    }
}

