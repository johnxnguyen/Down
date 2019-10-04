//
//  DownTextView.swift
//  Down
//
//  Created by John Nguyen on 03.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if !os(watchOS)

#if canImport(UIKit)

import UIKit
public typealias TextView = UITextView

#elseif canImport(AppKit)

import AppKit
public typealias TextView = NSTextView

#endif

/// A text view capable of parsing and rendering markdown via the AST.
open class DownTextView: TextView {

    // MARK: - Properties

    open var styler: Styler

    #if canImport(UIKit)

    open override var text: String! {
        didSet {
            guard oldValue != text else { return }
            try? render()
        }
    }

    #elseif canImport(AppKit)

    open override var string: String {
        didSet {
            guard oldValue != string else  { return }
            try? render()
        }
    }

    #endif


    // MARK: - Init

    public convenience init(frame: CGRect, styler: Styler = DownStyler()) {
        self.init(frame: frame, styler: styler, layoutManager: DownLayoutManager())
    }

    init(frame: CGRect, styler: Styler, layoutManager: NSLayoutManager) {
        self.styler = styler

        let textStorage = NSTextStorage()
        let textContainer = NSTextContainer()

        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        super.init(frame: frame, textContainer: textContainer)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    open func render() throws {
        #if canImport(UIKit)
        let down = Down(markdownString: text)
        let markdown = try down.toAttributedString(styler: styler)
        attributedText = markdown

        #elseif canImport(AppKit)
        guard let textStorage = textStorage else { return }
        let down = Down(markdownString: string)
        let markdown = try down.toAttributedString(styler: styler)
        textStorage.replaceCharacters(in: textStorage.wholeRange, with: markdown)

        #endif
    }
}

#endif
