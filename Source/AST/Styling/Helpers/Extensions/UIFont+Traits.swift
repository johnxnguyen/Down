//
//  UIFont+Traits.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import UIKit
public typealias DownFontDescriptor = UIFontDescriptor

#elseif canImport(AppKit)

import AppKit
public typealias DownFontDescriptor = NSFontDescriptor

#endif

extension DownFont {

    var isBold: Bool {
        return contains(.strong)
    }

    var isItalic: Bool {
        return contains(.emphasis)
    }

    var isMonospace: Bool {
        return contains(.monoSpace)
    }

    var bold: DownFont {
        return with(.strong) ?? self
    }

    var italic: DownFont {
        return with(.emphasis) ?? self
    }

    var monospace: DownFont {
        return with(.monoSpace) ?? self
    }

    private func with(_ trait: DownFontDescriptor.SymbolicTraits) -> DownFont? {
        guard !contains(trait) else { return self }

        var traits = fontDescriptor.symbolicTraits
        traits.insert(trait)

        #if canImport(UIKit)
        guard let newDescriptor = fontDescriptor.withSymbolicTraits(traits) else { return nil }
        return DownFont(descriptor: newDescriptor, size: pointSize)

        #elseif canImport(AppKit)
        let newDescriptor = fontDescriptor.withSymbolicTraits(traits)
        return DownFont(descriptor: newDescriptor, size: pointSize)

        #endif
    }

    private func contains(_ trait: DownFontDescriptor.SymbolicTraits) -> Bool {
        return fontDescriptor.symbolicTraits.contains(trait)
    }
}

#if canImport(UIKit)

private extension DownFontDescriptor.SymbolicTraits {

    static let strong = DownFontDescriptor.SymbolicTraits.traitBold
    static let emphasis = DownFontDescriptor.SymbolicTraits.traitItalic
    static let monoSpace = DownFontDescriptor.SymbolicTraits.traitMonoSpace
}

#elseif canImport(AppKit)

private extension DownFontDescriptor.SymbolicTraits {

    static let strong = DownFontDescriptor.SymbolicTraits.bold
    static let emphasis = DownFontDescriptor.SymbolicTraits.italic
    static let monoSpace = DownFontDescriptor.SymbolicTraits.monoSpace
}

#endif
