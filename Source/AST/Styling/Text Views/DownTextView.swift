//
//  DownTextView.swift
//  Down
//
//  Created by John Nguyen on 03.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class DownTextView: UITextView {

    // MARK: - Properties

    open var styler: Styler

    open override var text: String! {
        didSet {
            guard oldValue != text else { return }
            try? render()
        }
    }

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
        let down = Down(markdownString: text)
        attributedText = try down.toAttributedString(styler: styler)
    }
}

#endif
