//
//  UIFont+Traits.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

extension UIFont {

    var isBold: Bool {
        return contains(.traitBold)
    }

    var isItalic: Bool {
        return contains(.traitItalic)
    }

    var bold: UIFont {
        return with(.traitBold) ?? self
    }

    var italic: UIFont {
        return with(.traitItalic) ?? self
    }

    private func with(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        guard !contains(trait) else { return self }

        var traits = fontDescriptor.symbolicTraits
        traits.insert(trait)

        guard let newDescriptor = fontDescriptor.withSymbolicTraits(traits) else { return nil }

        // 0 means the size remains the same as before.
        return UIFont(descriptor: newDescriptor, size: 0)
    }

    private func contains(_ trait: UIFontDescriptor.SymbolicTraits) -> Bool {
        return fontDescriptor.symbolicTraits.contains(trait)
    }
}

#endif
