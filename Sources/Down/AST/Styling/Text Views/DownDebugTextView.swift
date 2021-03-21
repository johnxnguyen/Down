//
//  DownDebugTextView.swift
//  Down
//
//  Created by John Nguyen on 06.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS) && !os(Linux)

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

/// A text view capable of parsing and rendering markdown via the AST, as well as line fragments.
///
/// See `DownDebugLayoutManager`.

public class DownDebugTextView: DownTextView {

    // MARK: - Life cycle

    public init(frame: CGRect, styler: Styler = DownStyler()) {
        super.init(frame: frame, styler: styler, layoutManager: DownDebugLayoutManager())
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

#endif
